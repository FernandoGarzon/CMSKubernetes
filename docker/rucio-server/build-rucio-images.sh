#! /bin/sh

set -e

export CMS_VERSION=1.23.4.nano1
export RUCIO_VERSION=1.23.4

docker build --build-arg RUCIO_VERSION=$RUCIO_VERSION -t cmssw/rucio-server:release-$CMS_VERSION  -f Dockerfile.nano .
docker push cmssw/rucio-server:release-$CMS_VERSION

cd ../rucio-daemons
docker build -f Dockerfile.nano --build-arg RUCIO_VERSION=$RUCIO_VERSION -t cmssw/rucio-daemons:release-$CMS_VERSION .
docker push cmssw/rucio-daemons:release-$CMS_VERSION

cd ../rucio-probes
docker build --build-arg RUCIO_VERSION=$RUCIO_VERSION -t cmssw/rucio-probes:release-$CMS_VERSION .
docker push cmssw/rucio-probes:release-$CMS_VERSION

cd ../rucio-sync
docker build  --build-arg RUCIO_VERSION=$CMS_VERSION -t cmssw/rucio-sync:release-$CMS_VERSION .
docker push cmssw/rucio-sync:release-$CMS_VERSION

cd ../rucio-ui
docker build --build-arg RUCIO_VERSION=$RUCIO_VERSION -t cmssw/rucio-ui:release-$CMS_VERSION -f Dockerfile.nano .
docker push cmssw/rucio-ui:release-$CMS_VERSION