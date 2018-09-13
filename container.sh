sudo docker stop chatbot
sudo docker rm chatbot
sudo docker rmi themuser/chatbot:1.0


sudo docker build -t themuser/chatbot:1.0 .
sudo docker run -it --name chatbot themuser/chatbot:1.0

