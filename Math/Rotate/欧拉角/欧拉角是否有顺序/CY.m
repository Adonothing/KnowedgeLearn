%% 文件头

% @file    CY.m
% @brief   绕 y 轴旋转
% @details 绕 y 轴逆时针旋转，z 到 x 为正方向
% @author  Adunas
% @date    2024-08-09

%% 函数

% @brief   绕 y 轴旋转
% @details 绕 y 轴逆时针旋转，z 到 x 为正方向
function result = CY(theta)

result = [
    cos(theta), 0, -sin(theta);
    0,           1, 0;
    sin(theta),  0, cos(theta)
];

end