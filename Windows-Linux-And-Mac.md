Applicable for Linux distribution Debian and its derivatives, as well as Mac.

Contribution by Kneelawk#0623 on Discord.

# MCSH Tutorials
This is a set of commands and other tutorials I have found on the discord server.

## Install MCSH Client manually Windows Linux and Mac
1. Install `kubectl` [tutorial](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (If using mac, go to the section: using native package management or Snap/Homebrew)
2. Install `kubelogin` [setup](https://github.com/int128/kubelogin#setup) using Homebrew, Krew or directly to your /usr/bin/ folder from their Github Release page
3. Download and add our blue & red cert at [https://github.com/mcserverhosting-net/scoop/tree/master/mcsh](https://github.com/mcserverhosting-net/scoop/tree/master/mcsh) and place them in `/usr/local/share/ca-certificates/`, then run `sudo update-ca-certificates`. If youre on a MAC, you can download these and double click them to add them as described [here](https://www.eduhk.hk/ocio/content/faq-how-add-root-certificate-mac-os-x).
4. Run the following setup commands for kubectl: <br/>
   ```sh
   kubectl config set-cluster mcsh-na --server=https://cluster.mcserverhosting.red:6443 && \
   kubectl config set-cluster mcsh-eu --server=https://cluster.mcserverhosting.blue:6443 && \
   kubectl config set-credentials mcsh-oauth --exec-command=kubectl --exec-arg=oidc-login --exec-arg=get-token --exec-arg=--oidc-issuer-url=https://keycloak.sfxworks.net/auth/realms/mcsh --exec-arg=--oidc-client-id=account --exec-arg=--oidc-client-secret=ee3d1b8f-b533-41d7-8efc-8c8767497f4e --exec-arg=--oidc-redirect-url-hostname=login.mcserverhosting.net --exec-api-version=client.authentication.k8s.io/v1beta1 && \
   kubectl config set-context mcsh-na --cluster=mcsh-na --user=mcsh-oauth && \
   kubectl config set-context mcsh-eu --cluster=mcsh-eu --user=mcsh-oauth && \
   echo alias mcsh="kubectl" >> ~/.bashrc && \
   source ~/.bashrc
   ```
5. Proceed with the Configuration section in [our setup article](https://mcserverhosting.net/support/post/how-to-setup-mcsh/)

## Get Your Server's Pod Name
Run: <br/>
```sh
mcsh get pods
```
<br/>
Your server's pod name should be listed along with the server's ssh server.

## Connect to Your Minecraft Server
To connect to the input and output of your server, run: <br/>
```sh
mcsh attach -it server1-0
```
<br/>
Replace `server1-0` with whatever your server's pod name is.

Note: In order to disconnect, some have said that the key combination `Ctrl+P` followed by `Ctrl+Q` will disconnect their terminal from their running server, but in my case, I just had to close the terminal window.

## Get Your Server's Configuration File
Run: <br/>
```sh
mcsh get mineraftserver -o yaml >> your-server.yaml
```

## Apply a New Server Configuration File
Run: <br/>
```sh
mcsh apply -f your-server.yaml
```

## Edit Your Server's Configuration File Without Downloading It
Run: <br/>
```sh
mcsh edit minecraftserver
```

## Setup an ANAME Server to Point to Your Minecraft Server
Use `51.222.70.233` as the target in your ANAME record for your DNS and reference your desired domain under `spec.network.domainName` in your `mcsh edit minecraftserver` config.

For example, if you were wanting to host your server at `mc.example.com`, you would go to your ANAME record config and set a record to have the prefix/host `mc`, and to point it to the ip `51.222.70.233`. Then, in your `mcsh edit minecraftserver` yaml config, set the property `spec.network.domainName` to `mc.example.com`. Then you're finished! It will likely take up to a day for the internet to update and know that `mc.example.com` now points to your minecraft server.
