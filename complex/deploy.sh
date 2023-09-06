docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push caiohbs/multi-client:latest
docker push caiohbs/multi-client:$SHA
docker push caiohbs/multi-server:latest
docker push caiohbs/multi-server:$SHA
docker push caiohbs/multi-worker:latest
docker push caiohbs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=caiohbs/multi-client:$SHA
kubectl set image deployments/server-deployment server=caiohbs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=caiohbs/multi-worker:$SHA