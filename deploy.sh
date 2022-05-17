docker build -t jasoncohen07/multi-client:latest -t jasoncohen07/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jasoncohen07/multi-server:latest -t jasoncohen07/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jasoncohen07/multi-worker:latest -t jasoncohen07/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jasoncohen07/multi-client:latest
docker push jasoncohen07/multi-server:latest
docker push jasoncohen07/multi-worker:latest

docker push jasoncohen07/multi-client:$SHA
docker push jasoncohen07/multi-server:$SHA
docker push jasoncohen07/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jasoncohen07/multi-server:$SHA
kubectl set image deployments/client-deployment client=jasoncohen07/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jasoncohen07/multi-worker:$SHA