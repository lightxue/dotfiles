import { SearchService } from '../services/search-service';

describe('SearchService', () => {
  const service = new SearchService();

  describe('搜索功能', () => {
    it('通过名称搜索', () => {
      const results = service.searchCities('北京市');
      expect(results[0]?.city.name).toBe('北京市');
      expect(results[0]?.score).toBe(100);
    });

    it('通过编码搜索', () => {
      const results = service.searchCities('110000');
      expect(results[0]?.city.code).toBe('110000');
    });

    it('模糊搜索', () => {
      const results = service.searchCities('北京');
      expect(results.some(r => r.city.name.includes('北京'))).toBe(true);
    });

    it('限制结果数量', () => {
      expect(service.searchCities('北京', { limit: 3 }).length).toBeLessThanOrEqual(3);
    });
  });

  describe('边界处理', () => {
    it('空查询返回空数组', () => {
      expect(service.searchCities('')).toEqual([]);
      expect(service.searchCities('   ')).toEqual([]);
      expect(service.searchCities('')).toEqual([]);
    });

    it('无效查询返回空结果', () => {
      expect(service.searchCities('@#$%')).toEqual([]);
      expect(service.searchCities('a'.repeat(100))).toEqual([]);
    });
  });
});