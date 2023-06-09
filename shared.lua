Shared = Shared or {}
Shared.VineProps = "prop_fruit_basket"
Shared.Inventory = {Export = "qb-inventory", MaxWeight = 250000}
Shared.Currency = "bank"
Shared.FuelExport = "ps-fuel"
Shared.Module = {
	XP = true,
	Rebirth = true,
	Transformation = true,
	Selling = true
}

Shared.Keys = {
	StoreVehicle = 38,
}

Shared.Blips = {
	Starter = {Enabled = true, Sprite = 792, Colour = 5, Name = "Vineyard"},
	Activity = {Sprite = 270, Colour = 58, Name = "Harvest"}
}

Shared.Transformation = {
	MaxInput = 10,
	Animation = {Dict = "missclothing", Clip = "idle_storeclerk"},
	Places = {
		[1] = {
			Coords = {-1932.95, 2052.7, 140.5}, 
			Size = {0.15, 0.5, 0.5}, 
			Rotation = 345.0
		}
	},
	Transformation = {
		{ItemReceived = "vy-grapejuice", Cost = {Item = "vy-greengrapes", Amount = 4}},
		{ItemReceived = "vy-grapejuice", Cost = {Item = "vy-redgrapes", Amount = 8}}
	}
}

Shared.XP = {
	XPPerHarvest = 15000,
	XPForRebirth = 15000,
}

Shared.Ped = {
	Model = "csb_ary_02",
	Coords = vector4(-1924.47, 2058.71, 139.82, 341.97)
}

Shared.Vehicle = {
	Model = "sanchez2",
	Coords = vector3(-1924.34, 2066.77, 140.57),
}

Shared.Activity = {
	{
		Label = "Débutant", 
		Rewards = {
			{Item = "vy-greengrapes", Amount = {min = 2, max = 4}},
			{Item = "vy-redgrapes", Amount = {min = 2, max = 4}}
		}
	}	
}

Shared.Selling = {
	ItemsAvailable = {
		{Item = "vy-grapejuice", inBasket = false, PriceToSell = 20}
	},
	PedModel = "ig_bestmen",
	Vehicle = {Model = "mesa3", Coords = vector4(-1918.3, 2056.65, 140.48, 257.54)},
	Blips = {Sprite = 478, Colour = 16, Name = "Selling spot"},
	ResellEmplacement = {Coords = {-1134.24, 2683.12, 18.34}, Size = {0.30000000000001, 1.3, 2.4}, Rotation = 42.5}
}

Shared.VineZone = {
	[1] = {
		vector4(-1926.91, 1904.73, 173.96, 241.22),
		vector4(-1921.01, 1906.4, 171.68, 78.36),
		vector4(-1933.04, 1913.5, 172.73, 60.92),
		vector4(-1975.48, 1943.27, 169.53, 234.91),
		vector4(-1958.72, 1932.88, 170.44, 239.21),
		vector4(-1938.12, 1921.08, 171.23, 241.07),
		vector4(-1922.91, 1912.49, 170.63, 240.47),
		vector4(-1917.56, 1914.82, 168.75, 60.53),
		vector4(-1936.01, 1925.68, 169.16, 60.04),
		vector4(-1956.62, 1937.39, 167.76, 60.39),
		vector4(-1974.11, 1947.41, 166.75, 59.41),
		vector4(-1968.25, 1948.92, 164.64, 240.18),
		vector4(-1949.5, 1938.07, 166.16, 239.92),
		vector4(-1928.01, 1925.76, 167.42, 240.46),
		vector4(-1909.02, 1915.04, 166.75, 240.01),
		vector4(-1906.95, 1919.72, 164.4, 54.58),
		vector4(-1926.89, 1931.71, 164.82, 58.04),
		vector4(-1946.81, 1942.26, 163.68, 68.38),
		vector4(-1965.78, 1952.95, 162.15, 57.86),
		vector4(-1962.97, 1956.26, 159.8, 240.23),
		vector4(-1947.37, 1947.7, 161.11, 239.86),
		vector4(-1934.51, 1940.11, 163.1, 241.38),
		vector4(-1917.0, 1930.14, 163.4, 239.82),
		vector4(-1896.72, 1918.47, 162.69, 240.55),
		vector4(-1891.65, 1921.09, 160.63, 61.53),
		vector4(-1908.93, 1930.64, 161.4, 59.94),
		vector4(-1926.14, 1940.89, 161.8, 59.27),
		vector4(-1941.47, 1949.63, 159.25, 61.25),
		vector4(-1958.07, 1958.93, 157.37, 61.94),
		vector4(-1949.94, 1959.35, 155.61, 238.98),
		vector4(-1931.13, 1948.78, 158.71, 240.91),
		vector4(-1917.48, 1940.77, 160.04, 240.18),
		vector4(-1903.69, 1932.71, 159.58, 239.75),
		vector4(-1884.4, 1921.67, 159.02, 240.27),
		vector4(-1884.82, 1927.58, 157.21, 61.26),
		vector4(-1908.48, 1941.2, 157.8, 59.54),
		vector4(-1926.44, 1951.67, 156.88, 58.24),
		vector4(-1944.76, 1961.93, 153.42, 61.31),
		vector4(-1927.59, 1956.98, 154.27, 239.37),
		vector4(-1912.21, 1947.98, 156.27, 239.26),
		vector4(-1898.46, 1940.15, 155.71, 241.87),
		vector4(-1882.91, 1931.28, 155.51, 239.95),
		vector4(-1872.53, 1930.43, 153.67, 58.75),
		vector4(-1889.66, 1940.66, 153.75, 59.69),
		vector4(-1904.82, 1949.08, 154.37, 58.25),
		vector4(-1922.93, 1959.56, 152.5, 60.34),
		vector4(-1915.29, 1960.28, 151.58, 240.05),
		vector4(-1901.39, 1952.07, 152.55, 239.35),
		vector4(-1884.18, 1942.05, 152.02, 239.67),
		vector4(-1868.08, 1932.92, 151.83, 239.49),
		vector4(-1882.26, 1946.5, 150.07, 57.79),
		vector4(-1894.62, 1953.88, 150.38, 61.27),
		vector4(-1910.15, 1962.65, 149.83, 61.8),
		vector4(-1901.11, 1962.52, 148.66, 238.12),
		vector4(-1889.42, 1955.65, 148.66, 240.24),
		vector4(-1932.11, 1875.89, 176.68, 303.07),
		vector4(-1919.28, 1884.89, 172.52, 301.99),
		vector4(-1898.5, 1893.9, 166.05, 120.91),
		vector4(-1914.41, 1882.75, 170.46, 125.13),
		vector4(-1934.26, 1868.76, 176.63, 125.56),
		vector4(-1936.27, 1861.86, 176.16, 309.43),
		vector4(-1918.34, 1874.55, 170.51, 306.46),
		vector4(-1896.46, 1889.93, 164.86, 298.12),
		vector4(-1870.13, 1908.72, 157.3, 304.46),
		vector4(-1854.1, 1914.11, 151.64, 122.09),
		vector4(-1875.52, 1898.98, 158.59, 122.89),
		vector4(-1901.79, 1881.15, 165.27, 125.23),
		vector4(-1923.17, 1865.9, 171.34, 118.66),
		vector4(-1936.77, 1856.9, 175.5, 124.17),
		vector4(-1940.77, 1847.73, 175.55, 310.55),
		vector4(-1922.35, 1860.55, 170.03, 304.64),
		vector4(-1910.89, 1868.94, 167.41, 124.75),
		vector4(-1897.17, 1878.24, 163.4, 307.67),
		vector4(-1874.71, 1894.06, 157.62, 303.38),
		vector4(-1852.47, 1909.42, 150.91, 304.99),
		vector4(-1853.6, 1903.16, 150.79, 125.74),
		vector4(-1873.37, 1889.73, 156.49, 125.0),
		vector4(-1892.88, 1876.14, 161.9, 124.16),
		vector4(-1916.53, 1859.34, 167.47, 120.77),
		vector4(-1927.55, 1851.85, 170.37, 124.81),
		vector4(-1945.34, 1839.42, 175.89, 134.6),
		vector4(-1942.6, 1836.12, 173.98, 307.4),
		vector4(-1926.3, 1847.64, 168.94, 315.36),
		vector4(-1905.16, 1861.93, 163.58, 305.54),
		vector4(-1881.79, 1878.45, 158.42, 306.92),
		vector4(-1864.96, 1890.3, 153.27, 308.4),
		vector4(-1850.14, 1900.6, 149.12, 304.99),
		vector4(-1852.24, 1893.43, 149.22, 124.72),
		vector4(-1873.78, 1878.38, 154.99, 123.71),
		vector4(-1888.57, 1868.16, 159.38, 127.74),
		vector4(-1902.68, 1858.15, 162.07, 126.52),
		vector4(-1941.29, 1831.47, 172.55, 127.52)
	},
}