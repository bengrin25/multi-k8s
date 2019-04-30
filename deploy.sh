docker build -t bengrin/multi-client -t bengrin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bengrin/multi-server -t bengrin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bengrin/multi-worker -t bengrin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bengrin/multi-client:latest && docker push bengrin/multi-client:$SHA
docker push bengrin/multi-server:latest && docker push bengrin/multi-server:$SHA
docker push bengrin/multi-worker:latest && docker push bengrin/multi-worker:$SHA

kubectl apply --recursive -f k8s/
kubectl set image deployments/client-deployment client=bengrin/multi-client:$SHA
kubectl set image deployments/server-deployment server=bengrin/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bengrin/multi-worker:$SHA