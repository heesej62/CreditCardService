#This script starts an edit session, creates a JMS Server, 
#targets the jms server to the server WLST is connected to and creates
#a JMS System module with a jms queue and connection factory. The 
#jms queues and topics are targeted using sub-deployments. 


import sys
from java.lang import System

print "####################Starting the script####################"

myJmsSystemResource = "CapiQueue-jms"
factoryName = "CConFac"
jmsServerName = "myJMSServer"
queueName = "CQueue"

url = sys.argv[1]
usr = sys.argv[2]
password = sys.argv[3]

connect(usr,password, url)
edit()
startEdit()

//Step 1
servermb=getMBean("Servers/examplesServer")
    if servermb is None:
        print '####################No server MBean found####################'

else:
     //Step 2
    jmsMySystemResource = create(myJmsSystemResource,"JMSSystemResource")
      print '####################Created JMSSystemResource####################'
    jmsMySystemResource.addTarget(servermb)

    //Step 4
    theJMSResource = jmsMySystemResource.getJMSResource()

    //Step 5
    connfact1 = theJMSResource.createConnectionFactory(factoryName)
    print '####################Create connection factory####################'
    jmsqueue1 = theJMSResource.createQueue(queueName)
     print '#################### Create Queue ####################'
    connfact1.setJNDIName(factoryName)
    jmsqueue1.setJNDIName(queueName)

    //Step 7
    jmsqueue1.setSubDeploymentName('DeployToJMSServer1')  
     connfact1.setSubDeploymentName('DeployToJMSServer1')
    print '#################### Create Deployments ####################'
    jmsserver1mb = create(jmsServerName,'JMSServer')
    print '#################### Create Server ####################'
    jmsserver1mb.addTarget(servermb)

    //Step 10
    subDep1mb = jmsMySystemResource.createSubDeployment('DeployToJMSServer1')
    print '#################### Create SubDeployment ####################'
    subDep1mb.addTarget(jmsserver1mb)
