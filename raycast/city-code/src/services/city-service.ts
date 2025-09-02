import { City } from '../types/city.types';

/**
 * 城市数据服务
 * 提供城市数据的查询、索引和缓存功能
 */
export class CityService {
  private cities: City[] = [];
  private cityMap = new Map<string, City>();
  private nameIndex = new Map<string, City[]>();
  private prefixIndex = new Map<string, City[]>();

  constructor() {
    this.loadCities();
    this.buildIndexes();
  }

  private loadCities(): void {
    try {
      this.cities = require('../data/cities.json');
    } catch {
      this.cities = [];
    }
  }

  private buildIndexes(): void {
    this.cities.forEach(city => {
      this.cityMap.set(city.code, city);
      this.indexNames(city);
      this.indexPrefixes(city);
    });
  }

  private indexNames(city: City): void {
    const names = [city.name, ...(city.alias || [])];
    names.filter(Boolean).forEach(name => {
      const key = name!.toLowerCase();
      this.nameIndex.set(key, [...(this.nameIndex.get(key) || []), city]);
    });
  }

  private indexPrefixes(city: City): void {
    for (let i = 1; i <= city.code.length; i++) {
      const prefix = city.code.substring(0, i);
      this.prefixIndex.set(prefix, [...(this.prefixIndex.get(prefix) || []), city]);
    }
  }

  getByCode(code: string): City | null {
    return this.cityMap.get(code) ?? null;
  }

  searchByCodePrefix(prefix: string): City[] {
    if (!/^\d+$/.test(prefix)) return [];
    
    const results = this.prefixIndex.get(prefix) || [];
    const levelOrder = { '省份': 0, '城市': 1, '区县': 2 };
    return results.sort((a, b) => levelOrder[a.level] - levelOrder[b.level]);
  }

  searchByName(name: string): City[] {
    const query = name.toLowerCase();
    const results = new Set<City>();

    // 精确匹配 + 模糊匹配
    (this.nameIndex.get(query) || []).forEach(city => results.add(city));
    this.cities.forEach(city => {
      if (city.name.toLowerCase().includes(query)) {
        results.add(city);
      }
    });

    return Array.from(results);
  }

  getProvinces(): City[] {
    return this.cities.filter(city => city.level === '省份');
  }

  getCitiesByProvince(provinceCode: string): City[] {
    return this.cities.filter(city => 
      city.provinceCode === provinceCode && city.level === '城市'
    );
  }

  getAllCities(): City[] {
    return [...this.cities];
  }

  isValidCode(code: string): boolean {
    return /^\d{6}$/.test(code);
  }
}
