docker build -t shortendara/multi-client:latest -t shortendara/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t shortendara/multi-server:latest -t shortendara/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shortendara/multi-worker:latest -t shortendara/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shortendara/multi-server:latest
docker push shortendara/multi-client:latest
docker push shortendara/multi-worker:latest

docker push shortendara/multi-server:$SHA
docker push shortendara/multi-client:$SHA
docker push shortendara/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=shortendara/multi-client:$SHA
kubectl set image deployments/server-deployment server=shortendara/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shortendara/multi-worker:$SHA
#Testing GitHub Account
