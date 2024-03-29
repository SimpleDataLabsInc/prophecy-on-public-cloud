@description('The name of the Managed Cluster resource.')
param clusterName string = 'prophecycluster'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 8

@description('The size of the Virtual Machine.')
param agentVMSize string = 'standard_ds4_v2'

resource aks 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        minCount: agentCount
        maxCount: 16
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
        type: 'virtualmachinescalesets'
        enableAutoScaling: true
      }
    ]
    networkProfile: {
      loadBalancerSku: 'standard'
      outboundType: 'loadBalancer'
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: false
      }
    }
  }
}

output controlPlaneFQDN string = aks.properties.fqdn
