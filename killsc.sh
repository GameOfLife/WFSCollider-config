#!/bin/sh

KILLWHAT="\"killall scsynth \&\& killall SuperCollider \&\& killall jackdmp \&\& killall JackPilot\""

ssh gameoflife@192.168.2.11 "killall -9 WFSCollider \&\& killall -9 scsynth \&\& -9 killall SuperCollider \&\& -9 killall jackdmp \&\& -9 killall JackPilot"
ssh gameoflife@192.168.2.12 "killall -9 WFSCollider \&\& killall -9 scsynth \&\& -9 killall SuperCollider \&\& -9 killall jackdmp \&\& -9 killall JackPilot"
