function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Git git

install Ruby ruby2.3 ruby2.3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install PostgreSQL postgresql postgresql-contrib libpq-dev

sudo sed -i "s/#listen_address.*/listen_addresses '*'/" /etc/postgresql/9.4/main/postgresql.conf
sudo cat >> /etc/postgresql/9.4/main/pg_hba.conf <<EOF
  host    all         all         0.0.0.0/0             md5
EOF
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs

echo 'all set, rock on!'