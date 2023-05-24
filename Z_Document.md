#### environment
requirments.txt
minikube, Docker


#### high level overview of your systems design
Please see the section C&D of the diagram from link below
https://excalidraw.com/#json=91q0JFQzLjYSFWxTN_8RE,Zqz00w65phDwXKL85rKezA


####  LR logic
simple_linear_regr.py
lr_note.ipynb -- same logic but for testing/evaluation purpose

- train_main(): train the model & save the W,b parameters
- W,b: I would use Git LFS or Gdown for parameter files but currently the code is saving on the local server for the performance
- predict_main(): load model with pretrained parameters(read pkl files) & predict with inputs
** Call predict function directly with file_b.pickle, file_W.pickle if you want to avoid training time

#### Http request API
main.py

- web framework: Flask
- communication: json
- Instead of training the model for each prediction, save the trained model for efficiency
- GET/ train
  : trigger training the ML model, save pretrained model
- POST/ stream:'{"record": "0.5"}' ==> {"prediction":"[138.08]"}
  : single input ==> single prediction result
- POST/ batch: {"records": ["0.5", "0.1", "0.3"]} ==> {"predictions":"[[192.54], [186.90], [189.72]]"}
  : input array ==> array of results
- stream and batch use same prediction function from simple_linear_regr.py code

- to test API: run main.py & used commands below on bash
- cmds
curl http://localhost:5000/train
curl -X POST -H "Content-Type: application/json" -d '{"record": "0.5"}' http://localhost:5000/stream
curl -X POST -H "Content-Type: application/json" -d '{"records": ["0.5", "0.1", "0.3"]}' http://localhost:5000/batch

- future work todo: gRPC streaming will be needed for larger dataset communication. gRPC is for streaming big data by dividing it into small batches


#### Python package
Code -> Python Package makes it easier for developers to install and test the code.
setup.py contains metadata of the package - name, version, dependencies etc.

Install the package:
  pip install lr-sgd==1.0.0     #https://pypi.org/project/lr-sgd/1.0.0/

*personal note
Build the package: 
  it creates a 'dist' directory containing the built distribution files. 
  bash -- python setup.py sdist bdist_wheel
  bash -- twine upload *


#### Containerize the project
<!-- podman build -t lrimg
>> image id
podman run imgid
podman ps 
>> container id
podman exec -it [container id] curl http://localhost:5000/train -->

docker build -t [imgname] .

--from docker desktop cmd
curl http://localhost:5000/train

--or from bash
docker run [imgid]
docker exec -it [containerid] curl http://localhost:5000/train

--docker registry
https://hub.docker.com/repository/docker/sunnydockerkim/lrimg/general


#### Deployment
Deploy containers on Kubernetes Clusters
Please see the section C of diagram & Z_CICD.md

minikube start
minikube dashboard

kubectl apply -f bb.yaml
kubectl get deployments
kubectl get services

minikube service lrimg-service

kubectl cluster-info

**call api: Currently having an issue accessing from a public URL

#### Security points to consider
Data - customer information can't be encoded sometime for ML training
Public API - Authentication, Authorization, Input Validation(SQL injection), Rate Limiting(Brute force attacks, DoS attacks), Data protection(SSL, masking)
Git - code injection, Git credentials
Jenkins/docker etc - code injestion


#### 7. Document what componenets an enterprise machine learning system would have if you had the time to add it. 
What are some things that are critical to have versus nice to have?

versioned artifacts e.g. different stages of pretrained model with thier data-performance set
testing 