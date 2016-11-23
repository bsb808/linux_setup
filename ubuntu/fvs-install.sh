wget www.hyperrealm.com/libconfig/libconfig-1.5.tar.gz
tar zxvf libconfig-1.5.tar.gz 
cd libconfig-1.5
./configure
make 
sudo make install

cd ~/Projects/
mkdir FVS
cd FVS
svn co http://svn.bandbshares.com/frl/code/fvs/

cd fvs/trunk/utils
sudo ./aptget_for_lcm.sh

echo "source ~/Projects/FVS/fvs/trunk/utils/fvs_profile_bsb_desk_new_trunk" >> ~/.bashrc

source ~/.bashrc


