docker build -t dmeresz/multi-client:latest -t dmeresz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmeresz/multi-server:latest -t dmeresz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmeresz/multi-worker:latest -t dmeresz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmeresz/multi-client:latest
docker push dmeresz/multi-server:latest
docker push dmeresz/multi-worker:latest

docker push dmeresz/multi-client:$SHA
docker push dmeresz/multi-server:$SHA
docker push dmeresz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dmeresz/multi-client:$SHA
kubectl set image deployments/server-deployment server=dmeresz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dmeresz/multi-worker:$SHA