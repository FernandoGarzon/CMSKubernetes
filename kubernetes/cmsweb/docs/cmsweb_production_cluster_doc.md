## CMSWeb Production Cluster

There is a new production cluster in kuberneteds for CMSWeb in "CMS Web" project which is now available for developers to test their services. The URL to access this cluster is listed below:

- https://cmsweb-k8s-prod.cern.ch

Logs or application running ont this cluster are directed to CephFS volume and accessible in real time on `vocms0750` at `/cephfs/prod`

## Service Deployment Steps in K8S Production cluster:

- `ssh lxplus-cloud`

Use export KUBECONFIG to point to the relevant configurations for the clusters. Please note that these configurations are for the backend clusters as users will only need to work in the backend clusters to deploy/undeploy their services. The configuration file for backend cluster can be downloaded from [here](https://cernbox.cern.ch/index.php/s/GRiyu10zwWHlOKc/download)

- `wget https://cernbox.cern.ch/index.php/s/GRiyu10zwWHlOKc/download -O config.cmsweb-k8s-services-prod`
- `export OS_TOKEN=$(openstack token issue -c id -f value)`
- `export KUBECONFIG=$PWD/config.cmsweb-k8s-services-prod`
 
To see all pods in a particular namespace, following command can be used:
   - `kubectl -n <namespace> get pods`

To login to a specific pod, use:

   - `kubectl -n <namespace> exec -ti <pod-name> bash`

To delete a pod, use:
   - `kubectl -n <namespace> delete pod/<pod-name>`

To force delete a pod if above command does not work, use:
   - `kubectl -n <namespace> delete pod/<pod-name> --force --grace-period=0`

To deploy new service, the service first needs to be deleted and then redeployed. Following commands can be used for this purpose. 
- Clone this repository:

   - `git clone https://github.com/dmwm/CMSKubernetes.git`

- Go into CMSKubernetes/kubernetes/cmsweb directory:

- Update yaml file with the new version. For example open relevant service file (xxx.yaml e.g crabserver.yaml) and change version:
   - `vim services/xxx.yaml`

- Deploy newly changed yaml file. First delete old service from K8S and deploy new one. For example: 

   - `kubectl delete -f services/xxx.yaml`
   
 - Then, following command can be used to deploy service in testbed cluster. 
  - 
   ```
   cat services/xxx.yaml | sed -e "s,1 #PROD#,,g" | sed -e "s,#PROD#,      ,g" | sed -e "s,logs-cephfs-claim,logs-cephfs-claim-prod,g" | kubectl apply -f -
   ```

 - Please note that string #PROD# should be replaced by six spaces and logs-cephfs-claim should be replaced by logs-cephfs-claim-prod for production cluster as shown above in the command.


## CMSWEB Production Cluster Monitoring

There are monitoring pages for CMSWEB k8s production clusters in `https://monit-grafana.cern.ch` 

- The URL to access frontend cluster is available [here](https://monit-grafana.cern.ch/d/cmsweb-k8s-prod-frontend/cmsweb-k8s-prod-frontends?orgId=11&refresh=10s)

- The URL to access backend cluster is available [here](https://monit-grafana.cern.ch/d/cmsweb-k8s-prod-services/cmsweb-k8s-prod-services?orgId=11&refresh=30s)

These webpages provide cluster and pod resource usage in terms of `RAM` and `CPU`.  
