--Ancient Gear Triple Bite Hound Dog
function c511001544.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	c511001544.material_count=2
	c511001544.material={42878636,511001540}
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511001544.fcon)
	e0:SetOperation(c511001544.fop)
	c:RegisterEffect(e0)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c511001544.atkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(2)
	c:RegisterEffect(e2)
end
function c511001544.fcon(e,g,gc,chkf)
	if g==nil then return true end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,gc,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		if gc:IsHasEffect(511002961) then
			return mg:IsExists(aux.FConditionFilter22,1,gc,511001540,42878636,true,e:GetHandler())
		elseif gc:CheckFusionSubstitute(e:GetHandler()) then
			return mg:IsExists(aux.FConditionFilter21,1,nil,511001540,42878636,true)
		elseif gc:IsFusionCode(511001540) then
			return mg:IsExists(aux.FConditionFilter12,1,nil,42878636,true,e:GetHandler())
		elseif gc:IsFusionCode(42878636) then
			return mg:IsExists(aux.FConditionFilter12,1,nil,511001540,true,e:GetHandler()) 
				or mg:IsExists(Card.IsFusionCode,2,gc,42878636)
		end
	end
	local b1=0 local b2=0 local bw=0 local bwxct=0
	local ct=0
	local fs=chkf==PLAYER_NONE
	local tc=mg:GetFirst()
	while tc do
		local match=false
		if tc:IsFusionCode(42878636) then b1=1 match=true end
		if tc:IsFusionCode(511001540) then b2=1 match=true end
		if tc:IsHasEffect(511002961) then bwxct=bwxct+1 match=true end
		if not tc:IsHasEffect(511002961) and tc:CheckFusionSubstitute(e:GetHandler()) then bw=1 match=true end
		if match then
			if aux.FConditionCheckF(tc,chkf) then fs=true end
			ct=ct+1
		end
		tc=mg:GetNext()
	end
	if not fs then return false end
	if ct>1 and b1+b2+bw+bwxct>1 then return true end
	fs=chkf==PLAYER_NONE
	tc=mg:GetFirst()
	b1=0
	while tc do
		if tc:IsFusionCode(42878636) then b1=b1+1 if aux.FConditionCheckF(tc,chkf) then fs=true end end
		tc=mg:GetNext()
	end
	return b1>2
end
function c511001544.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local g=eg:Filter(Card.IsCanBeFusionMaterial,gc,e:GetHandler())
	local tc=gc
	local g1=nil
	local mat=Group.CreateGroup()
	local sg=g:Filter(aux.FConditionFilter22,nil,42878636,511001540,true,e:GetHandler())
	local sg2=sg:Clone()
	if gc then
		if chkf~=PLAYER_NONE and not aux.FConditionCheckF(gc,chkf) then
			sg2=sg:Filter(aux.FConditionCheckF,nil,chkf)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		if chkf~=PLAYER_NONE then g1=sg:FilterSelect(tp,aux.FConditionCheckF,1,1,nil,chkf)
		else g1=sg:Select(tp,1,1,nil) end
		tc=g1:GetFirst()
		sg:RemoveCard(tc)
		sg2:RemoveCard(tc)
	end
	local ok=false
	if tc:IsHasEffect(511002961) then
		sg:RemoveCard(tc)
		sg2:RemoveCard(tc)
		mat:AddCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g2=sg2:FilterSelect(tp,aux.FConditionFilter22,1,1,nil,42878636,511001540,true,e:GetHandler())
		local tc2=g2:GetFirst()
		if tc2:IsHasEffect(511002961) then ok=true sg:RemoveCard(tc2) sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler()) mat:AddCard(tc2)
		elseif tc2:CheckFusionSubstitute(e:GetHandler()) then
			ok=true mat:AddCard(tc2)
			sg:Remove(c511001544.FConditionFilterx,nil,e:GetHandler())
			sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler())
		elseif tc2:IsFusionCode(511001540) then
			g2:AddCard(tc)
			Duel.SetFusionMaterial(g2)
			return
		else
			ok=true
			mat:AddCard(tc2) sg:RemoveCard(tc2)
			sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler())
		end
	elseif tc:CheckFusionSubstitute(e:GetHandler()) then
		sg:Remove(c511001544.FConditionFilterx,nil,e:GetHandler())
		mat:AddCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g2=sg2:FilterSelect(tp,aux.FConditionFilter22,1,1,nil,42878636,511001540,true,e:GetHandler())
		local tc2=g2:GetFirst()
		if tc2:IsHasEffect(511002961) then ok=true sg:RemoveCard(tc2) sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler()) mat:AddCard(tc2)
		elseif tc2:IsFusionCode(511001540) then
			g2:AddCard(tc)
			Duel.SetFusionMaterial(g2)
			return
		else
			ok=true
			mat:AddCard(tc2)
			sg:RemoveCard(tc2)
			sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler())
		end
	elseif tc:IsFusionCode(511001540) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g2=sg2:FilterSelect(tp,aux.FConditionFilter12,1,1,nil,42878636,true,e:GetHandler())
		g2:AddCard(tc)
		Duel.SetFusionMaterial(g2)
		return
	else
		mat:AddCard(tc)
		sg:RemoveCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g2=sg2:FilterSelect(tp,aux.FConditionFilter22,1,1,nil,42878636,511001540,true,e:GetHandler())
		local tc2=g2:GetFirst()
		if tc2:IsHasEffect(511002961) then ok=true sg:RemoveCard(tc2) sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler()) mat:AddCard(tc2)
		elseif tc2:CheckFusionSubstitute(e:GetHandler()) then
			ok=true mat:AddCard(tc2)
			sg:Remove(c511001544.FConditionFilterx,nil,e:GetHandler())
			sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler())
		elseif tc2:IsFusionCode(511001540) then
			g2:AddCard(tc)
			Duel.SetFusionMaterial(g2)
			return
		else
			mat:AddCard(tc2)
			sg:RemoveCard(tc2)
			sg:Remove(c511001544.FConditionFilterx2,nil,e:GetHandler())
		end
	end
	if not ok or (sg:IsExists(aux.FConditionFilter12,1,nil,42878636,true,e:GetHandler()) and Duel.SelectYesNo(tp,93)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		local g3=sg:Select(tp,1,1,nil)
		mat:Merge(g3)
	end
	Duel.SetFusionMaterial(mat)
end
function c511001544.FConditionFilterx(c,fc)
	return c:CheckFusionSubstitute(fc) and not c:IsHasEffect(511002961) and not c:IsFusionCode(42878636,511001540)
end
function c511001544.FConditionFilterx2(c,fc)
	return c:IsFusionCode(511001540) and not c:CheckFusionSubstitute(fc)
end
function c511001544.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511001544.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511001544.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
