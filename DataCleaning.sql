

--Standrized Date Column
select SaleDateConverted
From PortFolioProjectss..Housing

update PortFolioProjectss..Housing
set saledate=convert(date,saledate)

Alter table PortFolioProjectss..Housing
Add SaleDateconverted date

update [dbo].[Housing]
set SaledateConverted=convert(date,saledate)

use PortfolioProjectss
Select SaleDateConverted 
from housing

----------------------------------------------------
--Papulate Property Address

select PropertyAddress
From PortFolioProjectss..Housing
where PropertyAddress is null

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from PortFolioProjectss..Housing a
join PortFolioProjectss..Housing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from PortFolioProjectss..Housing a
join PortFolioProjectss..Housing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking Address into(Address,city,state)
select 
SUBSTRING(PropertyAddress,1,charindex(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,charindex(',',PropertyAddress)+1,len(propertyAddress)) as Address
from PortFolioProjectss..Housing

update PortFolioProjectss..Housing
set saledate=convert(date,saledate)

Alter table PortFolioProjectss..Housing
Add  propertsplitadd nvarchar(255)

update PortFolioProjectss..Housing
set propertsplitadd =  SUBSTRING(PropertyAddress,1,charindex(',',PropertyAddress)-1)   

Alter table PortFolioProjectss..Housing
Add  PropertSplitCity nvarchar(255)

update PortFolioProjectss..Housing
set PropertSplitCity = SUBSTRING(PropertyAddress,charindex(',',PropertyAddress)+1,len(propertyAddress))

select *
From PortFolioProjectss..Housing


select OwnerAddress
from PortFolioProjectss..Housing
select
PARSENAME(replace(ownerAddress,',','.'),3),
PARSENAME(replace(ownerAddress,',','.'),2),
PARSENAME(replace(ownerAddress,',','.'),1)
From PortFolioProjectss..Housing

Alter table PortFolioProjectss..Housing
Add  ownerSplitAddress nvarchar(255)
update PortFolioProjectss..Housing
set ownerSplitAddress =PARSENAME(replace(ownerAddress,',','.'),3)


Alter table PortFolioProjectss..Housing
Add  ownerSpliCity nvarchar(255)
update PortFolioProjectss..Housing
set ownerSpliCity =PARSENAME(replace(ownerAddress,',','.'),2)

Alter table PortFolioProjectss..Housing
Add  ownerSplitState nvarchar(255)
update PortFolioProjectss..Housing
set ownerSplitState =PARSENAME(replace(ownerAddress,',','.'),1)


select *
from PortFolioProjectss..Housing


--Change SoldAs Vacant Y to Yes and N to No
select Distinct(SoldAsVacant),COUNT(soldasVacant)
from PortFolioProjectss..Housing
group by SoldAsVacant
order by 2

select SoldAsVacant,
	case when SoldAsVacant ='Y' then 'Yes'
	when SoldAsVacant ='N' then 'No'
	else SoldAsVacant
	end
from PortFolioProjectss..Housing

update PortFolioProjectss..Housing
set SoldAsVacant = case when SoldAsVacant ='Y' then 'Yes'
	when SoldAsVacant ='N' then 'No'
	else SoldAsVacant
	end

--Remove Duplicates

Select *
from PortFolioProjectss..Housing

with CTEDuplicateRoW As(
select *,
	ROW_NUMBER() Over(
	partition by
	parcelID,
	PropertyAddress,
	SaleDate,
	SalePrice,
	LegalReference
	order by 
		uniqueID
	)
		 RowNum	
from PortFolioProjectss..Housing
)
select * from CTEDuplicateRoW
where RowNum > 1
order by PropertyAddress

--Delete unused Column

Select *
from PortFolioProjectss..Housing

Alter table PortFolioProjectss..Housing
drop column taxDistrict
