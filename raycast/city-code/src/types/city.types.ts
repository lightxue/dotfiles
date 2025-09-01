export type AdministrativeLevel = '省份' | '城市' | '区县';
export type MatchType = 'exact' | 'prefix' | 'alias' | 'popular';

export interface City {
  code: string;
  name: string;
  province: string;
  provinceCode: string;
  level: AdministrativeLevel;
  isActive: boolean;
  alias?: string[];
}

export interface SearchResult {
  city: City;
  score: number;
  matchType: MatchType;
  matchDescription?: string;
}

export interface SearchOptions {
  limit?: number;
}