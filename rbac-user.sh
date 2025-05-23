kubectl create ns dev
kubectl create ns staging

kubectl config get-contexts
sudo adduser anna

sudo usermod anna -aG sudo

openssl genrsa -out anna.key 2048
openssl req -new -key anna.key -out anna.csr -subj "/CN=anna/O=K8"
sudo openssl x509 -req -in anna.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out anna.crt -days 1800

cp anna.* /home/anna/
sudo chown anna:anna /home/anna/anna.*
su - anna

mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown -R anna:anna ~/.kube

kubectl config set-credentials anna --client-certificate=anna.crt --client-key=anna.key
kubectl config set-context anna-context --cluster=kubernetes --namespace=dev --user=anna
kubectl config use-context anna-context

kubectl apply -f developer-role.yaml
kubectl apply -f developer-role-binding.yaml
