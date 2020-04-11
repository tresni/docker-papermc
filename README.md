# tresni/papermc

[PaperMC](https://papermc.io/) extends and improves the Bukkit and Spigot APIs for Minecraft servers. This repository setups up a drop-dead simple PaperMC Minecraft server with no required configuration and easy access to world, plugin, and configuration files via mount points.

## Usage

### docker

```
docker create --name=papermc \
	-v <path/to/world>:/world \
	-v <path/to/plugins>:/plugins \
	-v <path/to/config>:/config \
	--restart=unless-stopped \
	tresni/papermc
```

If you want log files locally, add `-v <path/to/logs>:/minecraft/logs` to the above

## Parameters

| Parameter | Function |
| - | - |
`-p 25565` | Minecraft server port
`-e INIT_MEMORY` | Set the initial memory size used by the JRE, defaults to `1G`
`-e MAX_MEMORY` | Set the maximum memory used by the JRE, defaults to `1G`
`-v /world` | All world files are stored here.  Since this is bukkit-like, make sure to copy DIMM-1 to [world_name]\_nether and DIMM-2 to [world_name]\_the\_end if you are migrating from a vanilla-like server
`-v /plugins` | All Paper, Spigot, Bukkit plugins go here
`-v /config` | server.properties, bukkit.yml, spigot.yml, paper.yml, help.yml, permissions.yml, commands.yml are all stored here
`-v /minecraft/logs` | Minecraft log files will be stored here.  If you don't map this they can still be seen in the container
