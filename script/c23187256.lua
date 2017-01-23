--No.93 希望皇ホープ・カイザー
function c23187256.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c23187256.xyzcon)
	e1:SetOperation(c23187256.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23187256,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c23187256.target)
	e2:SetOperation(c23187256.operation)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c23187256.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
end
c23187256.xyz_number=93
function c23187256.xyzm12(c,xyz,tp)
	return c23187256.mfilter1(c,xyz,tp) or c23187256.mfilter2(c,xyz,tp)
end
function c23187256.mfilter1(c,xyzc,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and c:GetOverlayCount()>0 and c:IsCanBeXyzMaterial(xyzc) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_XYZ_MATERIAL))
end
function c23187256.mfilter2(c,xyzc,tp)
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsHasEffect(511002793) and c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc)
	else
		return c:IsHasEffect(511002116)
	end
end
function c23187256.xyzfilter1(c,tp,mg,xyz,matg,ct,sg,min,matct,nodoub,notrip)
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
	if (not min or matct2==min) and ctc>=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	if c:IsType(TYPE_XYZ) then g=g:Filter(c23187256.xyzfilter2,nil,c:GetRank()) end
	local res2=false
	local res3=false
	local eqg=c:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
	if not sg then
		g:Merge(eqg)
	end
	local isDouble=false
	if not nodoub and c:IsHasEffect(511001225) and (not c.xyzlimit2 or c.xyzlimit2(xyz)) then
		isDouble=true
		res2=true
		if (not min or matct2==min) and ctc+1>=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	end
	if not notrip and c:IsHasEffect(511003001) and (not c.xyzlimit3 or c.xyzlimit3(xyz)) then
		res3=true
		if (not min or matct2==min) and ctc+2>=2 then return true end
	end
	return g:IsExists(c23187256.xyzfilter1,1,nil,tp,g,xyz,tg,ctc,tsg,min,matct2,false,false) 
		or (res2 and g:IsExists(c23187256.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false,false))
		or (res3 and g:IsExists(c23187256.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false,false))
end
function c23187256.xyzfilter2(c,rk)
	return c:GetRank()==rk or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c23187256.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	local sg=false
	if og then
		mg=og:Filter(c23187256.xyzm12,nil,c,tp)
		sg=mg:Clone()
		local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
		mg:Merge(mg2)
	else
		mg=Duel.GetMatchingGroup(c23187256.mfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		local mg2=Duel.GetMatchingGroup(c23187256.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
		mg:Merge(mg2)
	end
	local minchk=min
	if c:GetFlagEffect(999)~=0 then minchk=nil end
	return mg:IsExists(c23187256.xyzfilter1,1,nil,tp,mg,c,nil,0,sg,minchk,0,false)
end
function c23187256.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	if og and not min then
		if not og:IsExists(c23187256.xyzfilter1,1,nil,tp,og,c,nil,0,og,og:GetCount(),0,false) then
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
					and (not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true) or Duel.SelectYesNo(tp,65)) then
					isDouble=true
				end
				if tc:IsHasEffect(511003001) and (not tc.xyzlimit3 or tc.xyzlimit3(c)) and ct+2<3 then
					if (isDouble and not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,false,true)) 
						or (not isDouble and not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true)) 
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
			mg=og:Filter(c23187256.xyzm12,nil,c,tp)
			sg=mg:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
		else
			mg=Duel.GetMatchingGroup(c23187256.xyzm12,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
			local mg2=Duel.GetMatchingGroup(c23187256.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
			mg:Merge(mg2)
		end
		local ct=0
		local matg=Group.CreateGroup()
		while ct<2 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=mg:FilterSelect(tp,c23187256.xyzfilter1,1,1,nil,tp,mg,c,matg,ct,sg,nil,nil,false)
			local tc=g:GetFirst()
			local isDouble=false
			if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2
				and (not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,sg,nil,nil,true) or Duel.SelectYesNo(tp,65)) then
				isDouble=true
			end
			if tc:IsHasEffect(511003001) and (not tc.xyzlimit3 or tc.xyzlimit3(c)) and ct+2<2 then
				if (isDouble and not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,false,true)) 
					or (not isDouble and not c23187256.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true,true)) 
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
			if tc:IsType(TYPE_XYZ) then mg=mg:Filter(c23187256.xyzfilter2,nil,tc:GetRank()) end
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
		while mg:IsExists(c23187256.ExtraXyzMaterial,1,nil,matg,tp) and Duel.SelectYesNo(tp,513) do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=mg:FilterSelect(tp,c23187256.ExtraXyzMaterial,1,1,nil,matg,tp)
			local tc=g:GetFirst()
			if not sg then
				local eqg=tc:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
				mg:Merge(eqg)
			end
			mg:RemoveCard(tc)
			matg:AddCard(tc)
			if tc:IsType(TYPE_XYZ) then mg=mg:Filter(c23187256.xyzfilter2,nil,tc:GetRank()) end
			if tc:IsHasEffect(511002116) then
				tc:RegisterFlagEffect(511002115,RESET_EVENT+0x1fe0000,0,0)
			end
			ct=ct+1
		end
		Duel.SendtoGrave(sg2,REASON_RULE)
		c:SetMaterial(matg)
		Duel.Overlay(c,matg)
	end
end
function c23187256.ExtraXyzMaterial(c,g,tp)
	local gg=g:Filter(aux.ValidXyzMaterial,nil)
	gg:AddCard(c)
	return not gg:IsExists(Auxiliary.TuneMagXyzFilter,1,nil,gg,tp)
end
function c23187256.filter(c,e,tp)
	return c:IsRankBelow(9) and c:IsAttackBelow(3000) and c:IsSetCard(0x48)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23187256.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23187256.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23187256.gfilter(c,rank)
	return c:GetRank()==rank
end
function c23187256.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if ect~=nil then ft=math.min(ft,ect) end
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(c23187256.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	local ct=c:GetOverlayGroup():GetClassCount(Card.GetCode)
	if ct>ft then ct=ft end
	if g1:GetCount()>0 and ct>0 then
		repeat
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g2=g1:Select(tp,1,1,nil)
			local tc=g2:GetFirst()
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			g1:Remove(c23187256.gfilter,nil,tc:GetRank())
			ct=ct-1
		until g1:GetCount()==0 or ct==0 or not Duel.SelectYesNo(tp,aux.Stringid(23187256,1))
		Duel.SpecialSummonComplete()
		Duel.BreakEffect()
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
	end
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetValue(c23187256.val)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetReset(RESET_PHASE+PHASE_END)
	e4:SetTargetRange(1,0)
	Duel.RegisterEffect(e4,tp)
end
function c23187256.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then
		return dam/2
	else return dam end
end
function c23187256.indfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48)
end
function c23187256.indcon(e)
	return Duel.IsExistingMatchingCard(c23187256.indfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
