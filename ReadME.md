# ChaosKit ⚡

break your app on purpose. watch it survive.

---

## what is this

ChaosKit is a small chaos engineering setup where you:

- run a dockerized app  
- break it intentionally (kill container, process, cpu stress)  
- monitor it in real-time  
- see it recover automatically  
- generate basic reports  

basically → simulate failure → detect → recover → log  

---

## features

- 🔥 chaos injection (kill container, process, cpu stress)
- 📡 live monitoring (UP / DOWN logs)
- 🚨 alert system when app goes down
- 🔄 auto recovery using docker
- 📊 simple report generation
- ⚙️ CLI to control everything

---

## setup

clone repo and run:

```bash
./chaoskit.sh start