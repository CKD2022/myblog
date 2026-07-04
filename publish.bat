@echo off
chcp 65001 >nul
echo ========================================
echo   印务生产数据 - 自动发布到 GitHub
echo ========================================
echo.

REM 1. 生成最新网站
echo [1/4] 正在生成网站...
python build.py
if %errorlevel% neq 0 (
    echo ❌ 生成失败，请检查 build.py 是否有错误！
    pause
    exit /b 1
)
echo ✅ 网站生成完成
echo.

REM 2. 添加所有更改
echo [2/4] 正在添加文件到 Git...
git add .
echo ✅ 文件已暂存
echo.

REM 3. 提交更改
set /p COMMIT_MSG="请输入提交说明（直接回车则使用默认信息）: "
if "%COMMIT_MSG%"=="" set COMMIT_MSG=更新报告网站
git commit -m "%COMMIT_MSG%"
echo.

REM 4. 推送到 GitHub
echo [3/4] 正在推送到 GitHub...
git push
if %errorlevel% neq 0 (
    echo ❌ 推送失败，请检查网络或 Git 配置！
    pause
    exit /b 1
)
echo ✅ 推送成功
echo.

echo ========================================
echo   🎉 网站已发布！稍后访问你的 GitHub Pages 即可看到更新。
echo ========================================
pause