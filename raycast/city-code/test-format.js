// 测试格式化的简单脚本
const { SearchService } = require('./dist/services/search-service.js');

const searchService = new SearchService();
const results = searchService.searchCities('北京');

console.log('搜索结果格式测试:');
console.log('搜索词: 北京');
console.log('结果数量:', results.length);

results.slice(0, 3).forEach((result, index) => {
  const city = result.city;
  const code = city.code;
  const formattedCode = `${code.slice(0, 2)} ${code.slice(2, 4)} ${code.slice(4, 6)}`;
  const hierarchy = [city.province, city.name].filter(Boolean).join(' → ');
  
  console.log(`\n${index + 1}. ${city.name}`);
  console.log(`   编码: ${formattedCode}`);
  console.log(`   层级: ${hierarchy}`);
  console.log(`   级别: ${city.level}`);
});