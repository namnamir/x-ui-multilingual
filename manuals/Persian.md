<div dir="rtl">

# راهنمای نصب پنل X-UI برای V2ray ،V2fly و Xray

این پنل، یک پنل چند زبانه برای مدیریت کاربران و اتصالات Xray است. کد اصلی این پنل به زبان چینی و توسط [Vaxilu](https://github.com/vaxilu/x-ui) طراحی و توسعه یافته است.

# ویژگی‌ها
- امکان مشاهدهٔ وضعیت سرور
- امکان مدیریت کاربران برای اتصال به پروتکل‌های مختلف
- نمایش نمودار و گراف برای مصرف منابع
- پشتیبانی از پروتکل‌های Vmess، Vless، Trojan، ShadowSocks، Dokodemo-door، Socks و HTTP
- امکان اعمال تغییرات در تنظیمات Xray
- امکان تعیین حجم دانلود و تاریخ انقضا برای هر کاربر
- امکان دریافت گواهی SSL برای پنل
- امکان نصب برنامه تنها با یک کلیک

# نصب / ارتقا پنل
برای نصب یا ارتقای پنل، تنها کافی است که دستور یک خطی زیر را اجرا کنید و سوال‌ها را جواب بدهید. پس از چند دقیقه، پنل قابل دست‌رس و استفاده است.
<div dir="ltr">

```bash
bash <(curl -Ls https://raw.githubusercontent.com/namnamir/x-ui-multilingual/master/install.sh)
```

</div>

## نصب پنل به صورت دستی
اگر به هر دلیلی امکان یا تمایل نصب پنل X-UI به صورت خودکار را ندارید. با استفاده از یکی از دو روش زیر می‌توانید پنل را روی سرور خود نصب کنید.
### استفاده از بسته‌های نرم‌افزاری کامپایل شده

۱. آخرین بستهٔ نرم‌افزاری را از پیوند https://github.com/namnamir/x-ui-multilingual/releases دریافت کنید. به احتمال زیاد معماری `amd64` مناسب‌ترین گزینه است.
> اگر معماری سرور شما نسبت به `amd64` متفاوت است، معماری مورد نظر خود را از فهرست بسته‌های نرم‌افزاری دریافت کنید

۲. بستهٔ نرم‌افزاری را به پوشتهٔ `/root/` روی سرور خود منتقل کنید و از حالت فشرده خارج کنید. به خاطر داشته باشید که برای این کار نیاز به اجرای دستورات با کاربر `root` هستید. در آخر دستورات زیر را اجرا کنید.
<div dir="ltr">

```bash
# go to the /root folder
cd /root/

# remove any existing (old version) X-UI
rm x-ui/ /usr/local/x-ui/ /usr/bin/x-ui -rf

# extract the package
tar -zxvf x-ui-linux-amd64.tar.gz

# make the bash file executable
chmod +x x-ui/x-ui x-ui/bin/xray-linux-* x-ui/x-ui.sh

# copy/move files & folders to the certain folders
cp x-ui/x-ui.sh /usr/bin/x-ui
cp -f x-ui/x-ui.service /etc/systemd/system/
mv x-ui/ /usr/local/

# enable and restart services
systemctl daemon-reload
systemctl enable x-ui
systemctl restart x-ui
```
</div>


### نصب پنل از طریق کامپایل فایل‌ها

۱. برنامه‌های *GoLang* و *GCC* روی سرور خود نصب کنید.
<div dir="ltr">

```bash
# install Snapd
apt install snapd

# install GoLang
snap install go --classic

# install GCC
apt install build-essential
```
</div>


۲. فایل‌ها را از مخزن گیت‌هاب دریافت کنید.
<div dir="ltr">

```bash
git clone https://github.com/namnamir/x-ui-multilingual.git
```
</div>


۳. به پوشهٔ برنامه بروید -جایی که فایل `main.go` قرار دارد- و برنامه را کامپایل کنید. خروجی این کار یک فایل باینری قابل اجرا به نامه `x-ui` خواهد بود.
<div dir="ltr">

```bash
go build
```
</div>


## دریافت گواهی SSL
با داشتن آدرس فایل‌های گواهی (گواهی عمومی و کلید) و اضافه کردن آن به پنل X-UI می‌توانید از امنیت بیشتری برخوردار باشید. برای این کار کافی است که پس از ورود به پنل، گزینهٔ `X-UI Panel Settings` را انتخاب کرده و در برگهٔ مربوط به تنظیمات پنل، مسیر گواهی‌ها را وارد کنید.

اما چه طور می‌شود این گواهی را ایجاد و مسیر آن را پیدا کرد؟ از طریق یکی از راه‌های زیر.

### با استفاده از Cloudflare
برای دریفات گواهی SSL از طریق Cloudflare، نیاز به داشتن موارد زیر است:
- یک دامنه که به پنل Cloudflare اضافه شده باشد
- آدرس ایمیل متصل به کلاودفلر
- [کلید API عمومی Cloudflare](https://dash.cloudflare.com/profile/api-tokens)

![چه طور کلید عمومی API Cloudflare را پیدا کنیم](https://github.com/namnamir/x-ui-multilingual/blob/main/img/cloudflare-global-api-key.png)

با داشتن این سه مورد، کافی است که اسکریپت پنل `x-ui` را اجرا کنید و گزینهٔ `16` را انتخاب کنید. سپس به سوال‌هایی که پرسیده می‌شود پاسخ دهید. چیزی شبیه به زیر خواهد بود

![درخواست گواهی SSL از طریق ACME و Cloudflare](https://github.com/namnamir/x-ui-multilingual/blob/main/img/x-ui-ssl-cloudflare.png)

اگر همه چیز خوب پیش برود و خطایی دریافت نکنید، چیزی شبیه به عکس زیر به شما نمایش داده خواهد شد. دو خطی که علامت‌زده شده‌اند، مسیرهایی که به آن‌ها نیاز داریم.

![مسیر گواهی SSL ایجاد شده روی سرور](https://github.com/namnamir/x-ui-multilingual/blob/main/img/x-ui-ssl-cloudflare-2.png)

### Let's Encrypt
با استفاده از دستور زیر Certbot یک گواهی دریافت کنید.
<div dir="ltr">

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
</div>


پس از نصب Certbot، دستور زیر را اجرا کنید تا مطمئن شوید که از نسخه‌ای بالاتر از `1.32.0` استفاده می‌کنید.
<div dir="ltr">

```bash
certbot --version
```
</div>


حال زمان درخواست گواهی SSL است. دستور زیر یک گواهی به شکل *Standalone* را برای شما درخواست می‌دهد. تنها کافی است که به جای `example.com` آدرس دامنهٔ خود را بگذارید.
<div dir="ltr">

```bash
certbot certonly --standalone --preferred-challenges http -d example.com
```
</div>

در نهایت، همان‌طور که در بخش قبل دیدید، مسیر گواهی ایجاد شده به شما نمایش داده می‌شود که برای امن کردن پنل مورد استفاده قرار می‌گیرد.
