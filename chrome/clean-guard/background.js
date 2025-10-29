const RULESET = 'ruleset_1';
const ICONS = {
  on: {
    '16': 'icons/icon16.png',
    '48': 'icons/icon48.png',
    '128': 'icons/icon128.png'
  },
  off: {
    '16': 'icons/icon16-disabled.png',
    '48': 'icons/icon48-disabled.png',
    '128': 'icons/icon128-disabled.png'
  }
};

// CleanGuard 状态管理：默认启用清爽模式，保护网页浏览体验
let enabled = true;

const isOn = () => enabled;

async function setStatus(on) {
  enabled = on;

  const rulesets = on
    ? { enableRulesetIds: [RULESET] }
    : { disableRulesetIds: [RULESET] };

  await chrome.declarativeNetRequest
    .updateEnabledRulesets(rulesets)
    .catch(e => console.error('规则更新失败:', e));

  await updateIcon(on);
}

async function updateIcon(on) {
  const path = on ? ICONS.on : ICONS.off;
  await chrome.action.setIcon({ path }).catch(() => {});
}

function toggle() {
  const on = !isOn();
  setStatus(on);
}

chrome.action.onClicked.addListener(() => {
  toggle();
});

chrome.tabs.onUpdated.addListener(
  (tabId, { status }) => {
    if (status === 'complete') {
      updateIcon(isOn());
    }
  }
);

chrome.tabs.onActivated.addListener(() => {
  updateIcon(isOn());
});

chrome.runtime.onMessage.addListener((msg, _, respond) => {
  if (msg.action === 'getStatus') {
    respond({ enabled: isOn() });
    return true;
  }
  if (msg.action === 'toggle') {
    toggle();
    respond({ enabled: isOn() });
    return true;
  }
});
