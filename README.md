# Nexus Prime Pool Miner (CPU Miner) Docker image.

[![Build Status](https://travis-ci.org/jamesbrink/docker-prime-pool-miner.svg?branch=master)](https://travis-ci.org/jamesbrink/docker-prime-pool-miner) [![Docker Automated build](https://img.shields.io/docker/automated/jamesbrink/prime-pool-miner.svg)](https://hub.docker.com/r/jamesbrink/prime-pool-miner/) [![Docker Pulls](https://img.shields.io/docker/pulls/jamesbrink/prime-pool-miner.svg)](https://hub.docker.com/r/jamesbrink/prime-pool-miner/) [![Docker Stars](https://img.shields.io/docker/stars/jamesbrink/prime-pool-miner.svg)](https://hub.docker.com/r/jamesbrink/prime-pool-miner/) [![](https://images.microbadger.com/badges/image/jamesbrink/prime-pool-miner.svg)](https://microbadger.com/images/jamesbrink/prime-pool-miner "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/jamesbrink/prime-pool-miner.svg)](https://microbadger.com/images/jamesbrink/prime-pool-miner "Get your own version badge on microbadger.com")  


## About

This is a build of the [Nexus Prime Pool Miner][prime-pool-miner]. This image actually uses a [forked version][forked-prime-pool-miner] of the offical repo. The forked version was listed on the offical website [Nexus website][nexusearth] as having better performance.  


## Usage Examples

```shell
docker run --name miner --cap-add sys_nice jamesbrink/prime-pool-miner <YOUR_NXS_ADDRESS>
```

[prime-pool-miner]: https://github.com/Nexusoft/PrimePoolMiner
[nexusearth]: https://nexusearth.com/
[forked-prime-pool-miner]: https://github.com/hg5fm/PrimePoolMiner
[Alpine Linux Image]: https://github.com/gliderlabs/docker-alpine
