--未来への希望
function c100000557.initial_effect(c)
        --Activate
        local e1=Effect.CreateEffect(c)
        e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
        e1:SetType(EFFECT_TYPE_ACTIVATE)
        e1:SetCode(EVENT_FREE_CHAIN)
		e1:SetCondition(c100000557.condition)
		e1:SetCost(c100000557.cost)
        e1:SetTarget(c100000557.target)
        e1:SetOperation(c100000557.activate)
        c:RegisterEffect(e1)
end
function c100000557.cfilter(c)
	return c:IsCode(24094653) and c:IsAbleToGraveAsCost()
end
function c100000557.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000557.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000557.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000557.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000557.filter23,tp,LOCATION_MZONE,0,1,nil)
end
function c100000557.filter1(c,e)
        return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c100000557.filter2(c,e,tp,m,f,chkf)
        return c:IsType(TYPE_FUSION) and (not f or f(c)) and c:IsCode(31111109)
                and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c100000557.target(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
                local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
                local mg1=Duel.GetMatchingGroup(c100000557.filter1,tp,LOCATION_DECK,0,nil,e)
                local res=Duel.IsExistingMatchingCard(c100000557.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
                if not res then
                        local ce=Duel.GetChainMaterial(tp)
                        if ce~=nil then
                                local fgroup=ce:GetTarget()
                                local mg2=fgroup(ce,e,tp)
                                local mf=ce:GetValue()
                                res=Duel.IsExistingMatchingCard(c100000557.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
                        end
                end
                return res
        end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000557.filter22(c)
        return c:IsSetCard(0x1f) and c:IsFaceup() and c:IsAbleToDeck()
end
function c100000557.filter23(c)
        return c:IsCode(89943723) and c:IsFaceup() and c:IsAbleToDeck()
end
function c100000557.activate(e,tp,eg,ep,ev,re,r,rp)
        local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
        local mg1=Duel.GetMatchingGroup(c100000557.filter1,tp,LOCATION_DECK,0,nil,e)
        local sg1=Duel.GetMatchingGroup(c100000557.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
        local mg2=nil
        local sg2=nil
        local ce=Duel.GetChainMaterial(tp)
        if ce~=nil then
                local fgroup=ce:GetTarget()
                mg2=fgroup(ce,e,tp)
                local mf=ce:GetValue()
                sg2=Duel.GetMatchingGroup(c100000557.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
        end
        if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
                local sg=sg1:Clone()
                if sg2 then sg:Merge(sg2) end
                Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
                local tg=sg:RandomSelect(tp,1,1,nil)
                local tc=tg:GetFirst()
                if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc)) then
					local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
					tc:SetMaterial(mat1)
					Duel.SendtoGrave(mat1,REASON_EFFECT)
					Duel.BreakEffect()
					local gtt=Duel.GetMatchingGroup(c100000557.filter22,tp,LOCATION_MZONE,0,nil,0x1f)
					if gtt:GetCount()>0 then
						mat1:Merge(gtt)
					end
					local gttc=Duel.SelectMatchingCard(tp,c100000557.filter23,tp,LOCATION_MZONE,0,1,1,nil)
					mat1:AddCard(gttc:GetFirst())
					Duel.SendtoDeck(mat1,tp,0,REASON_EFFECT)
					Duel.BreakEffect()
					Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
					
						local e1=Effect.CreateEffect(e:GetHandler())
						e1:SetDescription(aux.Stringid(100000557,0))
						e1:SetCategory(CATEGORY_ATKCHANGE)
						e1:SetType(EFFECT_TYPE_IGNITION)
						e1:SetRange(LOCATION_MZONE)
						e1:SetTarget(c100000557.copytg)
						e1:SetOperation(c100000557.copyop)
						e1:SetReset(RESET_EVENT+0x1fe0000)
						tc:RegisterEffect(e1)
                end
        end
end
function c100000557.filter33(c)
        return c:IsSetCard(0x1f) and c:IsType(TYPE_MONSTER)
			and not c:IsHasEffect(EFFECT_FORBIDDEN) and c:IsAbleToRemove()
end
function c100000557.copytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c100000557.filter33,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c100000557.copyop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c100000557.filter33,tp,LOCATION_DECK,0,1,1,nil)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=1 then	return end
		local code=tc:GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+0x1fe0000,1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(500)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e2)
	end
end
