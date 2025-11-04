// ==UserScript==
// @name         会议室助手
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  删除北塔和连廊楼层的会议室
// @match        https://meeting.woa.com/*
// @match        http://meeting.woa.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // 删除元素的函数
    function deleteFloorItems() {
        let count = 0;
        document.querySelectorAll('div.floor-item').forEach(item => {
            const text = item.textContent.trim();
            if (text.startsWith('N') || text.startsWith('连廊')) {
                item.remove();
                count++;
            }
        });
        console.log(`已删除 ${count} 个北塔元素`);
    }

    // 检查是否应该显示按钮
    function shouldShowButton() {
        const buildingContainer = document.querySelector('div.custom-item-container.building');
        return buildingContainer && buildingContainer.textContent.includes('滨海');
    }

    // 更新按钮可见性
    function updateButtonVisibility() {
        const button = document.getElementById('delete-north-tower-btn');
        if (!button) {
            return;
        }

        const shouldShow = shouldShowButton();
        button.style.display = shouldShow ? 'block' : 'none';
    }

    // 添加按钮的函数
    function addDeleteButton() {
        // 查找所有 legend-item
        const legendItems = document.querySelectorAll('div.legend-item');

        if (legendItems.length === 0) {
            console.log('未找到 legend-item，等待页面加载...');
            return false;
        }

        // 检查是否已经添加过按钮
        if (document.getElementById('delete-north-tower-btn')) {
            // 按钮已存在，更新可见性
            updateButtonVisibility();
            return true;
        }

        // 获取最后一个 legend-item
        const lastLegendItem = legendItems[legendItems.length - 1];
        const parentContainer = lastLegendItem.parentElement;

        // 创建一个新的 legend-item 样式的容器
        const buttonContainer = document.createElement('div');
        buttonContainer.className = 'legend-item';
        buttonContainer.style.cssText = `
            margin-left: 10px;
        `;

        // 创建按钮
        const button = document.createElement('button');
        button.id = 'delete-north-tower-btn';
        button.textContent = '🗑️ 删除北塔';
        button.style.cssText = `
            padding: 6px 16px;
            background: #e6f7ff;
            color: #1890ff;
            border: 1px solid #91d5ff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s;
            white-space: nowrap;
        `;

        // 鼠标悬停效果
        button.addEventListener('mouseenter', () => {
            button.style.background = '#bae7ff';
            button.style.borderColor = '#69c0ff';
        });
        button.addEventListener('mouseleave', () => {
            button.style.background = '#e6f7ff';
            button.style.borderColor = '#91d5ff';
        });

        // 点击效果
        button.addEventListener('mousedown', () => {
            button.style.background = '#91d5ff';
        });
        button.addEventListener('mouseup', () => {
            button.style.background = '#bae7ff';
        });

        // 点击事件
        button.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            deleteFloorItems();
        });

        // 将按钮添加到容器
        buttonContainer.appendChild(button);

        // 在最后一个 legend-item 后面插入
        if (lastLegendItem.nextSibling) {
            parentContainer.insertBefore(buttonContainer, lastLegendItem.nextSibling);
        } else {
            parentContainer.appendChild(buttonContainer);
        }

        // 设置初始可见性
        updateButtonVisibility();

        return true;
    }

    // 等待页面加载完成后添加按钮
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(addDeleteButton, 500);
        });
    } else {
        setTimeout(addDeleteButton, 500);
    }

    // 使用 MutationObserver 监听 DOM 变化
    const observer = new MutationObserver(() => {
        // 先确保按钮已添加
        addDeleteButton();
        // 然后更新按钮可见性
        updateButtonVisibility();
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

})();
