oc delete -f redis-route.yml 
oc delete -f deploy-redis.yml
oc delete -f redis-pvc.yml
oc delete -f redis-pv.yml
