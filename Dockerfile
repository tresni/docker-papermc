FROM openjdk:8-alpine

LABEL maintainer="brian.andrew@brianandjenny.com"
LABEL description="PaperMC server"
LABEL version="1.0"
# FROM openjdk:8-slim-buster

ARG MINECRAFT_VERSION=1.15.2
ARG PAPER_VERSION=latest

ENV INIT_MEMORY=1G
ENV MAX_MEMORY=1G

EXPOSE 25565

WORKDIR /minecraft
VOLUME /world
VOLUME /plugins
VOLUME /config
VOLUME /minecraft/logs

ADD https://papermc.io/api/v1/paper/${MINECRAFT_VERSION}/${PAPER_VERSION}/download paperclip.jar
#RUN java -jar paperclip.jar
RUN echo "eula=true" > eula.txt
RUN touch /config/help.yml && ln -s /config/help.yml
RUN touch /config/permission.yml && ln -s /config/permission.yml

# These flags from https://mcflags.emc.gs/
CMD java -server -Xms$INIT_MEMORY -Xmx$MAX_MEMORY \
	-XX:+UseG1GC -XX:+ParallelRefProcEnabled \
	-XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
	-XX:+DisableExplicitGC -XX:-OmitStackTraceInFastThrow \
	-XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
	-XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
	-XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 \
	-XX:G1MixedGCCountTarget=8 -XX:InitiatingHeapOccupancyPercent=15 \
	-XX:G1MixedGCLiveThresholdPercent=90 \
	-XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 \
	-XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=true \
	-Daikars.new.flags=true \
	-jar /minecraft/paperclip.jar \
	--noconsole --nogui \
	-W /world -P /plugins \
	-c /config/server.properties -S /config/spigot.yml -C /config/commands.yml \
	-b /config/bukkit.yml --paper /config/paper.yml
