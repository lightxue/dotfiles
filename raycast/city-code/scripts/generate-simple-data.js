const gb2260 = require('gb-t-2260');
const fs = require('fs');
const path = require('path');

// 简化数据结构，只保留中文和编码
function convertToSimpleFormat() {
  const cities = [];
  
  // 获取所有行政区划代码
  const codes = Object.keys(gb2260).filter(code => typeof gb2260[code] === 'string');
  
  // 按代码排序
  const sortedCodes = codes.sort();
  
  console.log(`找到 ${sortedCodes.length} 个行政区划代码`);
  
  for (const code of sortedCodes) {
    const name = gb2260[code];
    if (!name) continue;
    
    // 确定级别
    let level = '区县';
    if (code.endsWith('0000')) {
      level = '省份';
    } else if (code.endsWith('00')) {
      level = '城市';
    }
    
    // 确定省份
    let provinceCode = code.substring(0, 2) + '0000';
    let provinceName = gb2260[provinceCode] || name;
    
    // 生成别名（简化版）
    let alias = [];
    if (level === '省份') {
      alias = [name.replace('省', '').replace('市', '').replace('自治区', '')];
    } else if (level === '城市') {
      alias = [name.replace('市', '')];
    } else if (level === '区县') {
      alias = [name.replace('区', '').replace('县', '').replace('市', '')];
    }
    
    cities.push({
      code: code,
      name: name,
      province: level === '省份' ? name : provinceName,
      provinceCode: provinceCode,
      level: level,
      isActive: true,
      alias: alias
    });
  }
  
  return cities;
}

// 生成简化数据
console.log('正在生成简化版城市数据...');
const cities = convertToSimpleFormat();

// 验证关键城市
const keyCities = ['430100', '440306', '110000', '310000', '430000'];
console.log('\n🔍 验证关键城市：');
keyCities.forEach(code => {
  const city = cities.find(c => c.code === code);
  console.log(`${code}: ${city ? city.name : '❌ 未找到'}`);
});

// 统计信息
const stats = {
  total: cities.length,
  provinces: cities.filter(c => c.level === '省份').length,
  cities: cities.filter(c => c.level === '城市').length,
  districts: cities.filter(c => c.level === '区县').length
};

console.log('\n📊 数据统计：');
console.log(`总计: ${stats.total.toLocaleString()}`);
console.log(`省份: ${stats.provinces}`);
console.log(`城市: ${stats.cities}`);
console.log(`区县: ${stats.districts.toLocaleString()}`);

// 写入文件
const outputPath = path.join(__dirname, '..', 'src', 'data', 'cities.json');
fs.writeFileSync(outputPath, JSON.stringify(cities, null, 2));

console.log(`\n✅ 已生成 ${cities.length.toLocaleString()} 条简化城市数据到 ${outputPath}`);