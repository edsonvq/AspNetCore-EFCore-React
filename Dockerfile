FROM mcr.microsoft.com/dotnet/sdk:5.0 AS dotnet-build
LABEL maintainer "Edson V. Queiroz <edsonvq@outlook.com>"

WORKDIR /src
COPY ./back/src /src
RUN dotnet restore "/src/SysAtividade.API/SysAtividade.API.csproj"
RUN dotnet build "/src/SysAtividade.API/SysAtividade.API.csproj" -c Release -o /app/build

FROM dotnet-build AS dotnet-publish
RUN dotnet publish "/src/SysAtividade.API/SysAtividade.API.csproj" -c Release -o /app/publish

FROM node AS node-builder
WORKDIR /node
COPY ./front/sys-atividade-app /node
RUN npm install
RUN npm run build

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
EXPOSE 5050
RUN mkdir /app/wwwroot
COPY --from=dotnet-publish /app/publish .
COPY --from=node-builder /node/build ./wwwroot
ENTRYPOINT ["dotnet", "SysAtividade.API.dll"]
