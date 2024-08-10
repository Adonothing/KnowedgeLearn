%% 文件头

% @file    test_02.m
% @brief   欧拉角的旋转顺序
% @details 坐标系为东北天
% @details 航向角机身向右转为正（俯视）；
%          俯仰角为机头向上为正；
%          横滚角为右下为正（由后往前看）
% @details 俯仰、横滚、偏航三个旋转顺序是否有要求？
% @details 选择了三种不同的变化顺序，结果是不同的
% @details 结论：旋转是有顺序要求的
% @author  Adunas
% @date    2024-08-09


%% 三维坐标系绕坐标轴旋转

% 选择单位向量
xa = 1;
ya = 0;
za = 0;

a = [
    xa;
    ya;
    za
];

% 任意设置一个欧拉角
pitch = 0.3 * pi;
roll = -0.4 * pi;
yaw = 0.5 * pi;

% 选择不同的旋转方式
b1 = CY(roll)  * CX(pitch) * CZ(-yaw)  * a % 航向-俯仰-横滚 横滚*俯仰*航向
                                           % 默认旋转顺序
b2 = CX(pitch) * CY(roll)  * CZ(-yaw)  * a % 航向-横滚-俯仰 俯仰*横滚*航向
b3 = CZ(-yaw)  * CX(pitch) * CY(roll)  * a % 横滚-俯仰-航向 航向*俯仰*横滚
b4 = CZ(-yaw)  * CY(roll)  * CX(pitch) * a % 俯仰-横滚-航向 航向*横滚*俯仰


