const $ = id => document.getElementById(id);

let isOn;

function setUI(state, msg) {
  const states = {
    loading: {
      dot: 'loading',
      text: '加载中...',
      btn: true
    },
    error: {
      dot: '',
      text: msg,
      btn: true
    },
    on: {
      dot: 'enabled',
      text: '清爽模式已启用',
      btn: false,
      btnClass: 'enabled',
      btnText: '关闭清爽模式'
    },
    off: {
      dot: 'disabled',
      text: '清爽模式已关闭',
      btn: false,
      btnClass: 'disabled',
      btnText: '开启清爽模式'
    }
  };
  const s = states[state];
  $('status-dot').className = `status-dot ${s.dot}`;
  $('status-text').textContent = s.text;
  $('toggle-btn').className = `toggle-btn ${s.btnClass || ''}`;
  $('toggle-btn').disabled = s.btn;
  $('btn-text').textContent = s.btnText || '';
}

async function load() {
  try {
    const { enabled } = await chrome.runtime.sendMessage({
      action: 'getStatus'
    });
    isOn = enabled;
    setUI(isOn ? 'on' : 'off');
  } catch (e) {
    console.error('加载失败:', e);
    setUI('error', '加载失败，请重试');
  }
}

async function toggle() {
  try {
    setUI('loading');
    // 通知background切换状态
    const { enabled } = await chrome.runtime.sendMessage({
      action: 'toggle'
    });
    isOn = enabled;
    setUI(isOn ? 'on' : 'off');
  } catch (e) {
    console.error('切换失败:', e);
    setUI('error', '操作失败，请重试');
    setTimeout(load, 2000);
  }
}

$('toggle-btn').addEventListener('click', toggle);

document.addEventListener('DOMContentLoaded', () => {
  setUI('loading');
  load();
});
