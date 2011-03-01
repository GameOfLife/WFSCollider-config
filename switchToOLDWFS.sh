#!/bin/sh

ssh gameoflife@192.168.2.11 "killall -9 WFSCollider-Leiden ; killall -9 scsynth ; killall -9 SuperCollider ; killall -9 jackdmp ; killall -9 JackPilot ; open /Applications/autostart\ jackosx\ intelX.app ; sleep 10 ; open /Applications/SuperCollider/SuperCollider.app" &
ssh gameoflife@192.168.2.12 "killall -9 WFSCollider-Leiden ; killall -9 scsynth ; killall -9 SuperCollider ; killall -9 jackdmp ; killall -9 JackPilot ; open /Applications/autostart\ jackosx\ intel.app ; sleep 10 ; open /Applications/SuperCollider/SuperCollider.app" &