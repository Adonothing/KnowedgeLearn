%% 文件头

% @file    CX.m
% @brief   绕 x 轴旋转
% @details 绕 x 轴逆时针旋转，y 到 z 为正方向
% @author  Adunas
% @date    2024-08-07

%% 函数

% @brief   绕 x 轴旋转
% @details 绕 x 轴逆时针旋转，y 到 z 为正方向
function result = CX(theta)

result = [
    1, 0,           0;
    0, cos(theta),  sin(theta);
    0, -sin(theta), cos(theta)
];

end