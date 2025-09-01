import { CityService } from '../services/city-service';

describe('CityService', () => {
  const service = new CityService();

  describe('核心功能', () => {
    it('通过编码查询城市', () => {
      expect(service.getByCode('110000')?.name).toBe('北京市');
      expect(service.getByCode('999999')).toBeNull();
    });

    it('通过名称搜索城市', () => {
      expect(service.searchByName('北京市')[0]?.name).toBe('北京市');
      expect(service.searchByName('北京').some(c => c.name.includes('北京'))).toBe(true);
    });

    it('通过编码前缀搜索', () => {
      const cities = service.searchByCodePrefix('11');
      expect(cities.length).toBeGreaterThan(0);
      expect(cities.every(c => c.code.startsWith('11'))).toBe(true);
    });
  });

  describe('数据验证', () => {
    const cities = service.getAllCities();

    it('数据格式正确', () => {
      cities.forEach(city => {
        expect(city.code).toMatch(/^\d{6}$/);
        expect(['省份', '城市', '区县']).toContain(city.level);
        expect(city.name).toBeDefined();
      });
    });

    it('省份编码规范', () => {
      const provinces = cities.filter(c => c.level === '省份');
      provinces.forEach(p => expect(p.code.endsWith('0000')).toBe(true));
    });

    it('省份列表唯一', () => {
      const provinces = service.getProvinces();
      const names = new Set(provinces.map(p => p.name));
      expect(names.size).toBe(provinces.length);
    });
  });
});