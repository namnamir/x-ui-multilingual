# X-UI Panel in English

X-UI is a graphical user interface that let you manage users and servers. It supports multiple protocols including Shadowsocks, V2ray, Xray, Trojan, Dokodemo-door and other protocols. You can also monitor VPS performance and traffic usage in real time.

> This script is a fork of the X-UI panel [developed by Vaxilu](https://github.com/vaxilu/x-ui).

# Features

- System status monitoring
- Support multi-user and multi-protocol, web page visualization operation
- Supported protocols: Vmess, Vless, Trojan, ShadowSocks, Dokodemo-door, Socks, HTTP
- Support for configuring more transport configurations
- Traffic statistics, limit traffic, limit expiration time
- Customizable Xray configuration template
- Support HTTPS access panel (self-provided domain name + ssl certificate)
- Support one-click SSL certificate application and automatic renewal

# Install & Upgrade
It is a one-line (one-click) installation of X-UI panel. Just run the following line, in some minutes, you will have the full service.
```bash
bash <(curl -Ls https://raw.githubusercontent.com/namnamir/x-ui-multilingual/master/install.sh)
```

## Manual Installation

### Use the Existing Packages

1. Download the latest package from https://github.com/namnamir/x-ui-multilingual/releases. You might need to select `amd64` as the architecture.
> If your CPU architecture is anything rather than `amd64`, replace `amd64` with the propre architecture

2. Move the package to the path `/root/`. Remember to use the user `root` or equivalent. Finally, run the following commands.
```bash
# go to the /usr/local/ folder
cd /usr/local/

# remove any existing (old version) X-UI
rm x-ui/ /usr/local/x-ui/ /usr/bin/x-ui -rf

# extract the package & remove the compressed file
tar -zxvf x-ui-linux-amd64.tar.gz
rm x-ui-linux-amd64.tar.gz

# make the bash file executable
chmod +x x-ui/x-ui x-ui/bin/xray-linux-* x-ui/x-ui.sh

# copy/move files & folders to the certain folders
cp x-ui/x-ui.sh /usr/bin/x-ui
cp -f x-ui/x-ui.service /etc/systemd/system/

# enable and restart services
systemctl daemon-reload
systemctl enable x-ui
systemctl restart x-ui
```

### Build from the Scratch

1. Install *GoLang* and *GCC* on your server.
```bash
# install Snapd
apt install snapd

# install GoLang
snap install go --classic

# install GCC
apt install build-essential
```

2. Clone the Git repository.
```bash
git clone https://github.com/namnamir/x-ui-multilingual.git
```

3. Go to the pulled folder and build the *GoLang* package; where `main.go` is located. The output would be an executable binary file named `x-ui`.
```bash
go build
```

4. Remain in the pulled folder and run the following commands.
```bash
# create a folder
mkdir /usr/local/x-ui

# make the bash files executable
chmod +x x-ui bin/xray-linux-* x-ui.sh

# copy/move files & folders to the ceated folder
cp x-ui.sh /usr/bin/x-ui
cp -r bin/ x-ui x-ui.sh x-ui.service /usr/local/x-ui

# enable and restart services
systemctl daemon-reload
systemctl enable x-ui
systemctl restart x-ui
```

## SSL Certificate
By having the link to certificates (private and public ones), you can add them in the X-UI panel. Just login, go to the settings (`X-UI Panel Settings`) and paste the paths to the corresponding fields.

How to get these paths? Through one of the following ways.

### Through Cloudflare
To get the SSL certificate through Cloudflare, you need to have the following items:
- A domain name imported to Cloudflare
- Your Cloudflare email
- The [Global API Key of Cloudflare](https://dash.cloudflare.com/profile/api-tokens)

![How to find Global API key in Cloudflare](https://github.com/namnamir/x-ui-multilingual/blob/main/img/cloudflare-global-api-key.png)

Now, just run the X-UI script by typing `x-ui` and pressing Enter and press `16` and answer the questions are asked.

![ACME SSL Certificate through Cloudflare](https://github.com/namnamir/x-ui-multilingual/blob/main/img/x-ui-ssl-cloudflare.png)

If everything goes well, you will see something like the following image, just copy the two lines marked.

![SSL Certificate Location on the Server](https://github.com/namnamir/x-ui-multilingual/blob/main/img/x-ui-ssl-cloudflare-2.png)

### Let's Encrypt
Follow the following commands to install *Certbot* and issue a certificate.
```bash
# remove exisitng Certbot
sudo apt remove certbot

# install Snapd
apt install snapd

# Install core packages for Snap and update it
sudo snap install core; sudo snap refresh core

# install Certbot
sudo snap install --classic certbot

# create the link
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

To verify the installation of *Certbot*, get the version; it should be above `1.32.0`.
```bash
certbot --version
```

Now, it is the time to get the certificate. Run the following command to get the certificate in the *Standalone* mode.
```bash
certbot certonly --standalone --preferred-challenges http -d example.com
```
As it is shown in the previous section, it would provide us with a path to certificates.

# Contribution & Questions
- Visit the [issues page](https://github.com/namnamir/x-ui-multilingual/issues)
- Or [discussion page](https://github.com/namnamir/x-ui-multilingual/discussions)
