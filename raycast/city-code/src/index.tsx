import { List, ActionPanel, Action, Icon, Color, Image } from '@raycast/api';
import { useState, useEffect } from 'react';
import { SearchService } from './services/search-service';
import { CityService } from './services/city-service';
import { SearchResult } from './types/city.types';
import { ClipboardUtil } from './utils/clipboard';

export default function SearchCityCodeCommand() {
  const [searchText, setSearchText] = useState('');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const searchService = new SearchService();
  const cityService = new CityService();

  useEffect(() => {
    async function search() {
      if (!searchText.trim()) {
        // 空输入时显示空结果
        setResults([]);
        return;
      }

      setIsLoading(true);
      try {
        // 智能识别输入类型并搜索
        const searchResults = searchService.searchCities(searchText, {
          limit: 20
        });
        setResults(searchResults);
      } catch (error) {
 console.error('搜索失败:', error);
        setResults([]);
      } finally {
        setIsLoading(false);
      }
    }

    const timeoutId = setTimeout(search, 300);
    return () => clearTimeout(timeoutId);
  }, [searchText]);

  const getLevelIcon = (level: string): { source: any; tintColor: any } => {
    switch (level) {
      case '省份':
        return { source: Icon.Map, tintColor: Color.Red };
      case '城市':
        return { source: Icon.Building, tintColor: Color.Orange };
      case '区县':
        return { source: Icon.House, tintColor: Color.Blue };
      default:
        return { source: Icon.QuestionMark, tintColor: Color.PrimaryText };
    }
  };

  const formatDisplayText = (city: any, searchText: string) => {
    const code = city.code;
    const name = city.name;
    const level = city.level;

    // 格式化编码：使用固定宽度
    const formattedCode = code;

    // 构建层级显示：省份→城市→区县
    const parts = [city.province];
    
    // 根据编码查找对应层级的地区
      
    // 城市：前4位 + 00 (仅当不是省级编码时)
    if (!code.endsWith('0000')) {
      const cityCode = code.substring(0, 4) + '00';
      const cityResult = cityService.getByCode(cityCode);
      if (cityResult) {
        parts.push(cityResult.name);
      }
    }
    
    // 区县：完整6位 (仅当不是市级编码时)
    if (!code.endsWith('00')) {
      parts.push(name);
    }
    const hierarchy = parts.join(' → ');

    return `${formattedCode}    ${hierarchy}`
  };

  const getInputTypeHint = (query: string) => {
    if (!query) return "输入城市名称或编码...";
    if (/^\d+$/.test(query)) return "编码搜索中...";
    return "城市名称搜索中...";
  };

  const formatAdministrativePath = (city: any) => {
    const parts = [city.province];
    
    // 城市：前4位 + 00 (仅当不是省级编码时)
    if (!city.code.endsWith('0000')) {
      const cityCode = city.code.substring(0, 4) + '00';
      const cityResult = cityService.getByCode(cityCode);
      if (cityResult) {
        parts.push(cityResult.name);
      }
    }
    
    // 区县：完整6位 (仅当不是市级编码时)
    if (!city.code.endsWith('00')) {
      parts.push(city.name);
    }
    
    return parts.join('');
  };

  return (
    <List
      isLoading={isLoading}
      onSearchTextChange={setSearchText}
      searchBarPlaceholder="输入城市名称或编码..."
      throttle
    >
      <List.Section title={searchText ? '搜索结果' : ''}>
        {results.map((result) => (
          <List.Item
            key={result.city.code}
            title={formatDisplayText(result.city, searchText)}
            subtitle=""
            accessories={[{ 
              text: result.city.level,
              icon: getLevelIcon(result.city.level)
            }]}
            actions={
              <ActionPanel>
                <Action.CopyToClipboard
                  title="复制"
                  content={/^\d+$/.test(searchText.trim()) ? result.city.name : result.city.code}
                  icon={Icon.Clipboard}
                />
                <ActionPanel.Section title="复制选项">
                  <Action.CopyToClipboard
                    title="复制城市编码"
                    content={result.city.code}
                    icon={Icon.BarCode}
                  />
                  <Action.CopyToClipboard
                    title="复制城市名称"
                    content={result.city.name}
                    icon={Icon.Text}
                  />
                  <Action.CopyToClipboard
                    title="复制完整名称"
                    content={formatAdministrativePath(result.city)}
                    icon={Icon.Map}
                  />
                </ActionPanel.Section>
              </ActionPanel>
            }
          />
        ))}
      </List.Section>

      {results.length === 0 && searchText && (
        <List.EmptyView
          icon={{ source: Icon.MagnifyingGlass, tintColor: Color.SecondaryText }}
          title="未找到匹配结果"
          description={`没有找到与 "${searchText}" 相关的城市或编码`}
        />
      )}
    </List>
  );
}
