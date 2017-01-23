--SNo.0 ホープ・ゼアル
function c52653092.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetRange(LOCATION_EXTRA)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCondition(c52653092.xyzcon)
	e0:SetOperation(c52653092.xyzop)
	e0:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52653092,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(aux.XyzCondition2(c52653092.ovfilter,c52653092.xyzop2))
	e1:SetTarget(aux.XyzTarget2(c52653092.ovfilter,c52653092.xyzop2))
	e1:SetOperation(aux.XyzOperation2(c52653092.ovfilter,c52653092.xyzop2))
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--cannot disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c52653092.effcon)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c52653092.effcon2)
	e3:SetOperation(c52653092.spsumsuc)
	c:RegisterEffect(e3)
	--atk & def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c52653092.atkval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
	--activate limit
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(52653092,1))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetRange(LOCATION_MZONE)
	e6:SetHintTiming(0,TIMING_DRAW_PHASE)
	e6:SetCountLimit(1)
	e6:SetCondition(c52653092.actcon)
	e6:SetCost(c52653092.actcost)
	e6:SetOperation(c52653092.actop)
	c:RegisterEffect(e6)
end
c52653092.xyz_number=0
function c52653092.cfilter(c)
	return c:IsSetCard(0x95) and c:GetType()==TYPE_SPELL and c:IsDiscardable()
end
function c52653092.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c52653092.xyzop2(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c52653092.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c52653092.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c52653092.xyzm12(c,xyz,tp)
	return c52653092.mfilter1(c,xyz,tp) or c52653092.mfilter2(c,xyz,tp)
end
function c52653092.mfilter1(c,xyzc,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_XYZ_MATERIAL))
end
function c52653092.mfilter2(c,xyzc,tp)
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsHasEffect(511002793) and c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc)
	else
		return c:IsHasEffect(511002116)
	end
end
function c52653092.xyzfilter1(c,tp,mg,xyz,matg,ct,sg,min,matct,nodoub,notrip)
	local tg
	local g=mg:Clone()
	if matg==nil or matg:GetCount()==0 then tg=Group.CreateGroup() else tg=matg:Clone() end
	g:RemoveCard(c)
	tg:AddCard(c)
	local tsg=false
	if sg then
		tsg=sg:Clone()
		tsg:RemoveCard(c)
	end
	local gg=tg:Filter(aux.ValidXyzMaterial,nil)
	if gg:IsExists(aux.TuneMagXyzFilter,1,nil,gg,tp) then return false end
	local ctc=ct+1
	local matct2=matct
	if not c:IsHasEffect(511002116) and min then
		matct2=matct+1
	end
	if min and matct2>min then return false end
	if (not min or matct2==min) and ctc>=3 and ctc<=3 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	if c:IsType(TYPE_XYZ) then g=g:Filter(c52653092.xyzfilter2,nil,c:GetRank()) end
	if ctc>3 then return false end
	local res2=false
	local res3=false
	local eqg=c:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
	if not sg then
		g:Merge(eqg)
	end
	local isDouble=false
	if not nodoub and c:IsHasEffect(511001225) and (not c.xyzlimit2 or c.xyzlimit2(xyz)) then
		if ctc+1<=3 then
			isDouble=true
			res2=true
		end
		if (not min or matct2==min) and ctc+1>=3 and ctc+1<=3 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	end
	if not notrip and c:IsHasEffect(511003001) and (not c.xyzlimit3 or c.xyzlimit3(xyz)) then
		if ctc+2<=3 then
			res3=true
		end
		if (not min or matct2==min) and ctc+2>=3 and ctc+2<=3 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	end
	return g:IsExists(c52653092.xyzfilter1,1,nil,tp,g,xyz,tg,ctc,tsg,min,matct2,false,false) 
		or (res2 and g:IsExists(c52653092.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false,false))
		or (res3 and g:IsExists(c52653092.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false,false))
end
function c52653092.xyzfilter2(c,rk)
	return c:GetRank()==rk or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c52653092.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	local sg=false
	if og then
		mg=og:Filter(c52653092.xyzm12,nil,c,tp)
		sg=mg:Clone()
		local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
		mg:Merge(mg2)
	else
		mg=Duel.GetMatchingGroup(c52653092.mfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		local mg2=Duel.GetMatchingGroup(c52653092.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
		mg:Merge(mg2)
	end
	local minchk=min
	if c:GetFlagEffect(999)~=0 then minchk=nil end
	return mg:IsExists(c52653092.xyzfilter1,1,nil,tp,mg,c,nil,0,sg,minchk,0,false)
end
function c52653092.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	if og and not min then
		if not og:IsExists(c52653092.xyzfilter1,1,nil,tp,og,c,nil,0,og,og:GetCount(),0,false) then
			local matg=Group.CreateGroup()
			local mg=og:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
			local ct=og:GetCount()
			tog=og:Clone()
			local tc=tog:GetFirst()
			local matct=0
			local ct=0
			while tc do
				local isDouble=false
				if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<3 
					and (not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true) or Duel.SelectYesNo(tp,65)) then
					isDouble=true
				end
				if tc:IsHasEffect(511003001) and (not tc.xyzlimit3 or tc.xyzlimit3(c)) and ct+2<3 then
					if (isDouble and not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,false,true)) 
						or (not isDouble and not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true)) 
						or Duel.SelectYesNo(tp,65) then
						local tct=2
						if isDouble then tct=1 end
						ct=ct+tct
					end
				end
				ct=ct+1
				if isDouble then ct=ct+1 end
				matct=matct+1
				mg:RemoveCard(tc)
				matg:AddCard(tc)
				tc=tog:GetNext()
			end
			while ct<3 do
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
				local sg=mg:Select(tp,1,1,nil)
				sg:GetFirst():RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
				ct=ct+1
				mg:Sub(sg)
				matg:Merge(sg)
			end
			matg:Remove(Card.IsHasEffect,nil,511002116)
			matg:Remove(Card.IsHasEffect,nil,511002115)
			local sg=Group.CreateGroup()
			local tc=matg:GetFirst()
			while tc do
				local sg1=tc:GetOverlayGroup()
				sg:Merge(sg1)
				tc=g:GetNext()
			end
			Duel.SendtoGrave(sg,REASON_RULE)
			c:SetMaterial(g)
			Duel.Overlay(c,g)
		else
			local sg=Group.CreateGroup()
			local tc=og:GetFirst()
			while tc do
				local sg1=tc:GetOverlayGroup()
				sg:Merge(sg1)
				tc=og:GetNext()
			end
			Duel.SendtoGrave(sg,REASON_RULE)
			c:SetMaterial(og)
			Duel.Overlay(c,og)
		end
	else
		local mg
		local sg=false
		if og then
			mg=og:Filter(c52653092.xyzm12,nil,c,tp)
			sg=mg:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
		else
			mg=Duel.GetMatchingGroup(c52653092.xyzm12,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
			local mg2=Duel.GetMatchingGroup(c52653092.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
			mg:Merge(mg2)
		end
		local ct=0
		local matg=Group.CreateGroup()
		while ct<3 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=mg:FilterSelect(tp,c52653092.xyzfilter1,1,1,nil,tp,mg,c,matg,ct,sg,nil,nil,false)
			local tc=g:GetFirst()
			local isDouble=false
			if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2
				and (not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,sg,nil,nil,true) or Duel.SelectYesNo(tp,65)) then
				isDouble=true
			end
			if tc:IsHasEffect(511003001) and (not tc.xyzlimit3 or tc.xyzlimit3(c)) and ct+2<3 then
				if (isDouble and not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,false,true)) 
					or (not isDouble and not c52653092.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true)) 
					or Duel.SelectYesNo(tp,65) then
					local tct=2
					if isDouble then tct=1 end
					ct=ct+tct
				end
			end
			if isDouble then ct=ct+1 end
			if not sg then
				local eqg=tc:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
				mg:Merge(eqg)
			end
			mg:RemoveCard(tc)
			matg:AddCard(tc)
			if tc:IsHasEffect(511002116) then
				tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			if tc:IsType(TYPE_XYZ) then mg=mg:Filter(c52653092.xyzfilter2,nil,tc:GetRank()) end
			ct=ct+1
		end
		matg:Remove(Card.IsHasEffect,nil,511002116)
		matg:Remove(Card.IsHasEffect,nil,511002115)
		local sg2=Group.CreateGroup()
		local tc=matg:GetFirst()
		while tc do
			local sg1=tc:GetOverlayGroup()
			sg2:Merge(sg1)
			tc=matg:GetNext()
		end
		Duel.SendtoGrave(sg2,REASON_RULE)
		c:SetMaterial(matg)
		Duel.Overlay(c,matg)
	end
end
function c52653092.effcon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c52653092.effcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c52653092.spsumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c52653092.chlimit)
end
function c52653092.chlimit(e,ep,tp)
	return tp==ep
end
function c52653092.atkval(e,c)
	return c:GetOverlayCount()*1000
end
function c52653092.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c52653092.actcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c52653092.actop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c52653092.actlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c52653092.actlimit(e,re,tp)
	return not re:GetHandler():IsImmuneToEffect(e)
end
