from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='dfr0592_driver',
            executable='driver',
            name='dfr0592_driver_node',
            output='screen'
        ),
        Node(
            package='mandeye_unicorn',
            executable='mandeye_unicorn',
            name='mandeye_unicorn_node',
            output='screen',
            arguments=['/opt/mid360_config_lio.json', '0', '/tmp/', '/tmp/']
        )
    ])
