--FNo.0 未来皇ホープ
function c65305468.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c65305468.xyzcon)
	e1:SetOperation(c65305468.xyzop)
	e1:SetValue(SUMMON_TYPE_XYZ)
	c:RegisterEffect(e1)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--avoid damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--control
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(65305468,0))
	e6:SetCategory(CATEGORY_CONTROL)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_DAMAGE_STEP_END)
	e6:SetTarget(c65305468.cttg)
	e6:SetOperation(c65305468.ctop)
	c:RegisterEffect(e6)
	--destroy replace
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_DESTROY_REPLACE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTarget(c65305468.reptg)
	c:RegisterEffect(e7)
end
c65305468.xyz_number=0
function c65305468.xyzm12(c,xyz,tp)
	return c65305468.mfilter1(c,xyz,tp) or c65305468.mfilter2(c,xyz,tp)
end
function c65305468.mfilter1(c,xyzc,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc) 
		and (c:IsControler(tp) or c:IsHasEffect(EFFECT_XYZ_MATERIAL))
end
function c65305468.mfilter2(c,xyzc,tp)
	if c:IsLocation(LOCATION_GRAVE) then
		return c:IsHasEffect(511002793) and c:IsType(TYPE_XYZ) and not c:IsSetCard(0x48) and c:IsCanBeXyzMaterial(xyzc)
	else
		return c:IsHasEffect(511002116)
	end
end
function c65305468.xyzfilter1(c,tp,mg,xyz,matg,ct,sg,min,matct,nodoub)
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
	if (not min or matct2==min) and ctc>=2 and ctc<=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	if c:IsType(TYPE_XYZ) then g=g:Filter(c65305468.xyzfilter2,nil,c:GetRank()) end
	if ctc>2 then return false end
	local res2=false
	local eqg=c:GetEquipGroup():Filter(Card.IsHasEffect,nil,511001175)
	if not sg then
		g:Merge(eqg)
	end
	local isDouble=false
	if not nodoub and c:IsHasEffect(511001225) and (not c.xyzlimit2 or c.xyzlimit2(xyz)) then
		if ctc+1<=2 then
			isDouble=true
			res2=true
		end
		if (not min or matct2==min) and ctc+1>=2 and ctc+1<=2 then return tg:IsExists(aux.XyzFCheck,1,nil,tp) end
	end
	return g:IsExists(c65305468.xyzfilter1,1,nil,tp,g,xyz,tg,ctc,tsg,min,matct2,false) 
		or (res2 and g:IsExists(c65305468.xyzfilter1,1,nil,tp,g,xyz,tg,ctc+1,tsg,min,matct2,false))
end
function c65305468.xyzfilter2(c,rk)
	return c:GetRank()==rk or c:IsHasEffect(511002116) or c:IsHasEffect(511001175)
end
function c65305468.xyzcon(e,c,og,min,max)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=nil
	local sg=false
	if og then
		mg=og:Filter(c65305468.xyzm12,nil,c,tp)
		sg=mg:Clone()
		local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
		mg:Merge(mg2)
	else
		mg=Duel.GetMatchingGroup(c65305468.mfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
		local mg2=Duel.GetMatchingGroup(c65305468.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
		mg:Merge(mg2)
	end
	local minchk=min
	if c:GetFlagEffect(999)~=0 then minchk=nil end
	return mg:IsExists(c65305468.xyzfilter1,1,nil,tp,mg,c,nil,0,sg,minchk,0,false)
end
function c65305468.xyzop(e,tp,eg,ep,ev,re,r,rp,c,og,min,max)
	if og and not min then
		if not og:IsExists(c65305468.xyzfilter1,1,nil,tp,og,c,nil,0,og,og:GetCount(),0,false) then
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
				if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2 
					and (not c65305468.xyzfilter1(tc,tp,mg,c,matg,ct,og,og:GetCount(),matct,true) or Duel.SelectYesNo(tp,65)) then
					isDouble=true
				end
				ct=ct+1
				if isDouble then ct=ct+1 end
				matct=matct+1
				mg:RemoveCard(tc)
				matg:AddCard(tc)
				tc=tog:GetNext()
			end
			while ct<2 do
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
			mg=og:Filter(c65305468.xyzm12,nil,c,tp)
			sg=mg:Clone()
			local mg2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_ONFIELD,0,nil,511002116)
			mg:Merge(mg2)
		else
			mg=Duel.GetMatchingGroup(c65305468.xyzm12,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c,tp)
			local mg2=Duel.GetMatchingGroup(c65305468.mfilter2,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil,c,tp)
			mg:Merge(mg2)
		end
		local ct=0
		local matg=Group.CreateGroup()
		while ct<2 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local g=mg:FilterSelect(tp,c65305468.xyzfilter1,1,1,nil,tp,mg,c,matg,ct,sg,nil,nil,false)
			local tc=g:GetFirst()
			local isDouble=false
			if tc:IsHasEffect(511001225) and (not tc.xyzlimit2 or tc.xyzlimit2(c)) and ct+1<2
				and (not c65305468.xyzfilter1(tc,tp,mg,c,matg,ct,sg,nil,nil,true) or Duel.SelectYesNo(tp,65)) then
				isDouble=true
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
			if tc:IsType(TYPE_XYZ) then mg=mg:Filter(c65305468.xyzfilter2,nil,tc:GetRank()) end
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
function c65305468.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and tc:IsRelateToBattle() and tc:IsControlerCanBeChanged() end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tc,1,0,0)
end
function c65305468.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToBattle() then
		Duel.GetControl(tc,tp,PHASE_BATTLE,1)
	end
end
function c65305468.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_EFFECT) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT) end
	if Duel.SelectYesNo(tp,aux.Stringid(65305468,1)) then
		c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		return true
	else return false end
end
