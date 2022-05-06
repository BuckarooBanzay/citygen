ARG ENGINE_VERSION=5.5.0
FROM registry.gitlab.com/minetest/minetest/server:${ENGINE_VERSION}

USER root
RUN apk add git &&\
    mkdir -p /root/.minetest/worlds/world/worldmods/ &&\
    git clone https://github.com/BuckarooBanzay/mtzip /root/.minetest/worlds/world/worldmods/mtzip &&\
    git clone https://github.com/BuckarooBanzay/mapblock_lib /root/.minetest/worlds/world/worldmods/mapblock_lib


ENTRYPOINT minetestserver --config /minetest.conf