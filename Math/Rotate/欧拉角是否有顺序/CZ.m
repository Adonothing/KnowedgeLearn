%% 文件头

% @file    CZ.m
% @brief   绕 z 轴旋转
% @details 绕 z 轴逆时针旋转，x 到 y 为正方向
% @author  Adunas
% @date    2024-08-07

%% 函数

% @brief   绕 z 轴旋转
% @details 绕 z 轴逆时针旋转，x 到 y 为正方向
function result = CZ(theta)

result = [  
    cos(theta),  sin(theta), 0;
    -sin(theta), cos(theta), 0;
    0,           0,          1
];

end