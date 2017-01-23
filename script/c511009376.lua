--Destiny HERO - Duskutopiaguy
function c511009376.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,90579153,aux.FilterBoolFunction(Card.IsFusionSetCard,0xc008),1,true,false)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511009376.regcon)
	e1:SetOperation(c511009376.regop)
	c:RegisterEffect(e1)
	-- Protection1
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67754901,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c511009376.indtg)
	e2:SetOperation(c511009376.indop)
	c:RegisterEffect(e2)
	-- Protection2
	--Negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12298909,0))
	e3:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511009376.condition)
	-- e1:SetCost(c511009376.cost)
	e3:SetTarget(c511009376.target)
	e3:SetOperation(c511009376.activate)
	c:RegisterEffect(e3)
end
function c511009376.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c511009376.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(42878636,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511009376.fustarg)
	e3:SetOperation(c511009376.fusop)
	e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e3)
end
function c511009376.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511009376.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c511009376.fustarg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(Card.IsCanBeFusionMaterial,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c511009376.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511009376.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511009376.fusop(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c511009376.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c511009376.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511009376.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end


----------------protection1------------------
function c511009376.indfilter(c)
	return c:IsFaceup() 
end
function c511009376.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009376.indfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009376.indfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009376.indfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511009376.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		tc:RegisterEffect(e3)
	end
end
-----------------------protection2------------------
function c511009376.filter(c)
    return c:IsType(TYPE_MONSTER) and c:IsOnField()
end
function c511009376.condition(e,tp,eg,ep,ev,re,r,rp)
    local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
    if ex and tg~=nil and tc+tg:FilterCount(c511009376.filter,nil)-tg:GetCount()>0 then
    e:SetLabelObject(tg)
    return true end
end
function c511009376.filter2(c,e,tp)
    return c:IsType(TYPE_MONSTER) and c:IsOnField() and c:IsCanBeEffectTarget(e)
end
function c511009376.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local g=e:GetLabelObject():FilterSelect(tp,c511009376.filter2,1,1,nil,e,tp)
    Duel.SetTargetCard(g)
end
function c511009376.activate(e,tp,eg,ep,ev,re,r,rp)
    local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
    local tc=Duel.GetFirstTarget()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EFFECT_DESTROY_REPLACE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTarget(c511009376.reptg)
    local i=0    
    local ct=Group.CreateGroup()
    while i<ev do
    ct:AddCard(Duel.CreateToken(tp,0))
    i=i+1
    end
    ct:KeepAlive()
    e1:SetLabelObject(ct)
    e1:SetLabel(cid)
    tc:RegisterEffect(e1)
end
function c511009376.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local ct=e:GetLabelObject():GetCount()
    if Duel.GetChainInfo(ct,CHAININFO_CHAIN_ID)==e:GetLabel() then
        Duel.Hint(HINT_CARD,0,511009376)
        return true end
end