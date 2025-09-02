import { City, SearchResult, SearchOptions } from '../types/city.types';
import { CityService } from './city-service';

export class SearchService {
  private cityService = new CityService();

  searchCities(query: string, options: SearchOptions = {}): SearchResult[] {
    const { limit = 20 } = options;
    const cleanQuery = query?.trim();

    if (!cleanQuery) return [];

    const results = /^\d+$/.test(cleanQuery) 
      ? this.searchByCode(cleanQuery)
      : this.searchByName(cleanQuery);

    return this.deduplicate(results)
      .sort((a, b) => b.score - a.score)
      .slice(0, limit);
  }

  private searchByCode(code: string): SearchResult[] {
    const results: SearchResult[] = [];

    const exact = this.cityService.getByCode(code);
    if (exact) {
      results.push({ city: exact, score: 100, matchType: 'exact', matchDescription: '编码精确匹配' });
    }

    this.cityService.searchByCodePrefix(code)
      .filter(city => city.code !== code)
      .forEach(city => {
        const score = Math.max(80, (code.length / city.code.length) * 100);
        results.push({ city, score, matchType: 'prefix', matchDescription: '编码前缀匹配' });
      });

    return results;
  }

  private searchByName(name: string): SearchResult[] {
    const query = name.toLowerCase();
    const results: SearchResult[] = [];

    this.cityService.getAllCities().forEach(city => {
      const searchTexts = [
        city.name.toLowerCase(),
        ...(city.alias || [])
      ];

      searchTexts.forEach(text => {
        if (text === query) {
          results.push({ city, score: 100, matchType: 'exact', matchDescription: '名称精确匹配' });
        } else if (text.includes(query)) {
          const score = Math.max(60, (query.length / text.length) * 100);
          results.push({ city, score, matchType: 'alias', matchDescription: '名称匹配' });
        }
      });
    });

    return results;
  }

  private deduplicate(results: SearchResult[]): SearchResult[] {
    const seen = new Set<string>();
    return results.filter(r => {
      if (seen.has(r.city.code)) return false;
      seen.add(r.city.code);
      return true;
    });
  }
}
