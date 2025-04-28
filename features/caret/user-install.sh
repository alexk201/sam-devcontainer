vcs import src < caret.repos
source /opt/ros/humble/setup.bash
bash setup_caret.sh

colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF

source /workspaces/caret_ws/install/local_setup.bash