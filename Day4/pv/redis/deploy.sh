oc apply -f redis-pv.yml
oc apply -f redis-pvc.yml
oc apply -f deploy-redis.yml
oc apply -f redis-route.yml 
