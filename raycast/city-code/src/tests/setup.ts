// Jest测试环境设置
import 'jest';

// 全局测试配置
beforeEach(() => {
  jest.clearAllMocks();
});

// 模拟全局对象
global.performance = global.performance || {
  now: () => Date.now(),
};

// 扩展Jest匹配器
declare global {
  namespace jest {
    interface Matchers<R> {
      toBeValidCode(): R;
      toBeValidCityName(): R;
    }
  }
}