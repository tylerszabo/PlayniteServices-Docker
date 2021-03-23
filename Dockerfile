FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster as builder

ARG BUILD_CONFIGURATION=Debug

WORKDIR /source/PlayniteBackend

RUN git clone --recurse-submodules --depth 1 https://github.com/tylerszabo/PlayniteBackend.git .

WORKDIR /source/PlayniteBackend/source/PlayniteServices

RUN dotnet restore
RUN dotnet build -o /source/out

FROM mcr.microsoft.com/dotnet/aspnet:3.1-alpine

WORKDIR /app

COPY --from=builder /source/out .

ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ARG UID=${UID:-0}
ARG GID=${GID:-0}

RUN mkdir /db && chown $UID:$GID /db && chmod 1777 .
USER $UID:$GID
VOLUME [ "/db" ]

CMD [ "dotnet", "PlayniteServices.dll" ]
